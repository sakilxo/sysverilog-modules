`timescale 1ns / 1ps

module i2c_master #(
    parameter integer CLK_DIV = 4
) (
    input  logic       clk,
    input  logic       rst,

    input  logic       start,
    input  logic       rw,
    input  logic [6:0] slave_addr,
    input  logic [7:0] data_in,

    output logic [7:0] data_out,
    output logic       busy,
    output logic       done,
    output logic       ack_error,

    inout  wire        sda,
    output logic       scl
);

    logic sda_out;
    logic sda_oe;

    assign sda = sda_oe ? sda_out : 1'bz;

    logic [31:0] clk_counter;

    logic [3:0] bit_count;
    logic [7:0] shift_reg;

    typedef enum logic [3:0] {
        IDLE,
        START_BIT,
        SEND_ADDR,
        ADDR_ACK,
        SEND_DATA,
        DATA_ACK,
        READ_DATA,
        READ_ACK,
        STOP_BIT
    } state_t;

    state_t state;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            clk_counter <= 32'd0;
            bit_count   <= 4'd0;
            shift_reg   <= 8'd0;
            data_out    <= 8'd0;

            busy        <= 1'b0;
            done        <= 1'b0;
            ack_error   <= 1'b0;

            scl         <= 1'b1;
            sda_out     <= 1'b1;
            sda_oe      <= 1'b1;

            state       <= IDLE;
        end else begin
            done <= 1'b0;

            if (state == IDLE) begin
                scl    <= 1'b1;
                sda_out <= 1'b1;
                sda_oe  <= 1'b1;

                if (start) begin
                    busy        <= 1'b1;
                    ack_error   <= 1'b0;
                    clk_counter <= 32'd0;
                    state       <= START_BIT;
                end
            end else begin

                if (clk_counter == CLK_DIV - 1) begin
                    clk_counter <= 32'd0;

                    case (state)

                        START_BIT: begin
                            // SDA goes low while SCL is high
                            sda_out <= 1'b0;
                            scl     <= 1'b1;

                            shift_reg <= {slave_addr, rw};
                            bit_count <= 4'd7;

                            state <= SEND_ADDR;
                        end

                        SEND_ADDR: begin
                            scl <= ~scl;

                            if (scl == 1'b0) begin
                                sda_out <= shift_reg[bit_count];
                            end else begin
                                if (bit_count == 4'd0) begin
                                    state <= ADDR_ACK;
                                end else begin
                                    bit_count <= bit_count - 1'b1;
                                end
                            end
                        end

                        ADDR_ACK: begin
                            scl    <= ~scl;
                            sda_oe <= 1'b0;

                            if (scl == 1'b1) begin
                                if (sda == 1'b1)
                                    ack_error <= 1'b1;

                                sda_oe <= 1'b1;

                                if (rw) begin
                                    bit_count <= 4'd7;
                                    shift_reg <= 8'd0;
                                    state <= READ_DATA;
                                end else begin
                                    bit_count <= 4'd7;
                                    shift_reg <= data_in;
                                    state <= SEND_DATA;
                                end
                            end
                        end

                        SEND_DATA: begin
                            scl <= ~scl;

                            if (scl == 1'b0) begin
                                sda_out <= shift_reg[bit_count];
                            end else begin
                                if (bit_count == 4'd0) begin
                                    state <= DATA_ACK;
                                end else begin
                                    bit_count <= bit_count - 1'b1;
                                end
                            end
                        end

                        DATA_ACK: begin
                            scl    <= ~scl;
                            sda_oe <= 1'b0;

                            if (scl == 1'b1) begin
                                if (sda == 1'b1)
                                    ack_error <= 1'b1;

                                sda_oe <= 1'b1;
                                state <= STOP_BIT;
                            end
                        end

                        READ_DATA: begin
                            scl    <= ~scl;
                            sda_oe <= 1'b0;

                            if (scl == 1'b1) begin
                                shift_reg[bit_count] <= sda;

                                if (bit_count == 4'd0) begin
                                    state <= READ_ACK;
                                end else begin
                                    bit_count <= bit_count - 1'b1;
                                end
                            end
                        end

                        READ_ACK: begin
                            scl    <= ~scl;
                            sda_oe <= 1'b1;

                            if (scl == 1'b0) begin
                                // NACK after one-byte read
                                sda_out <= 1'b1;
                            end else begin
                                data_out <= shift_reg;
                                state <= STOP_BIT;
                            end
                        end

                        STOP_BIT: begin
                            scl     <= 1'b1;
                            sda_oe  <= 1'b1;
                            sda_out <= 1'b1;

                            busy <= 1'b0;
                            done <= 1'b1;

                            state <= IDLE;
                        end

                        default: begin
                            state <= IDLE;
                            busy  <= 1'b0;
                        end

                    endcase
                end else begin
                    clk_counter <= clk_counter + 1'b1;
                end
            end
        end
    end

endmodule