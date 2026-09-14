`timescale 1ns / 1ps

module i2c_slave #(
    parameter logic [6:0] SLAVE_ADDR = 7'h50
) (
    input  logic       clk,
    input  logic       rst,

    input  logic       scl,
    inout  wire        sda,

    input  logic [7:0] data_in,

    output logic [7:0] data_out,
    output logic       valid
);

    logic sda_out;
    logic sda_oe;

    assign sda = sda_oe ? sda_out : 1'bz;

    logic scl_prev;
    logic sda_prev;

    logic [7:0] rx_shift_reg;
    logic [7:0] tx_shift_reg;

    logic [3:0] bit_count;

    typedef enum logic [2:0] {
        IDLE,
        ADDRESS,
        ADDRESS_ACK,
        WRITE_DATA,
        WRITE_ACK,
        READ_DATA,
        READ_ACK
    } state_t;

    state_t state;

    logic rw_bit;
    logic address_match;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            sda_out      <= 1'b1;
            sda_oe       <= 1'b0;

            scl_prev     <= 1'b1;
            sda_prev     <= 1'b1;

            rx_shift_reg <= 8'd0;
            tx_shift_reg <= 8'd0;

            bit_count    <= 4'd0;

            data_out     <= 8'd0;
            valid        <= 1'b0;

            rw_bit       <= 1'b0;
            address_match <= 1'b0;

            state        <= IDLE;
        end else begin

            valid    <= 1'b0;
            scl_prev <= scl;
            sda_prev <= sda;

            // START condition:
            // SDA goes LOW while SCL is HIGH
            if (sda_prev && !sda && scl) begin
                state         <= ADDRESS;
                bit_count     <= 4'd7;
                rx_shift_reg  <= 8'd0;
                sda_oe        <= 1'b0;
                address_match <= 1'b0;
            end

            // STOP condition:
            // SDA goes HIGH while SCL is HIGH
            else if (!sda_prev && sda && scl) begin
                state     <= IDLE;
                bit_count <= 4'd0;
                sda_oe    <= 1'b0;
            end

            else begin

                case (state)

                    IDLE: begin
                        sda_oe <= 1'b0;
                    end

                    // Receive address + R/W bit
                    ADDRESS: begin
                        if (!scl_prev && scl) begin
                            rx_shift_reg[bit_count] <= sda;

                            if (bit_count == 4'd0) begin
                                rw_bit <= sda;

                                if (rx_shift_reg[7:1] == SLAVE_ADDR) begin
                                    address_match <= 1'b1;
                                end

                                state <= ADDRESS_ACK;
                            end else begin
                                bit_count <= bit_count - 1'b1;
                            end
                        end
                    end

                    // ACK address
                    ADDRESS_ACK: begin
                        if (address_match) begin
                            if (scl && !scl_prev) begin
                                sda_oe  <= 1'b1;
                                sda_out <= 1'b0;
                            end

                            if (scl_prev && !scl) begin
                                sda_oe <= 1'b0;

                                if (rw_bit) begin
                                    tx_shift_reg <= data_in;
                                    bit_count    <= 4'd7;
                                    state        <= READ_DATA;
                                end else begin
                                    bit_count <= 4'd7;
                                    rx_shift_reg <= 8'd0;
                                    state <= WRITE_DATA;
                                end
                            end
                        end else begin
                            sda_oe <= 1'b0;
                            state  <= IDLE;
                        end
                    end

                    // Receive data from master
                    WRITE_DATA: begin
                        if (!scl_prev && scl) begin
                            rx_shift_reg[bit_count] <= sda;

                            if (bit_count == 4'd0) begin
                                data_out <= {rx_shift_reg[6:0], sda};
                                valid    <= 1'b1;
                                state    <= WRITE_ACK;
                            end else begin
                                bit_count <= bit_count - 1'b1;
                            end
                        end
                    end

                    // ACK received data
                    WRITE_ACK: begin
                        if (!scl_prev && scl) begin
                            sda_oe  <= 1'b1;
                            sda_out <= 1'b0;
                        end

                        if (scl_prev && !scl) begin
                            sda_oe <= 1'b0;
                            state  <= IDLE;
                        end
                    end

                    // Send data to master
                    READ_DATA: begin
                        if (!scl_prev && scl) begin
                            if (bit_count == 4'd0) begin
                                state <= READ_ACK;
                            end else begin
                                bit_count <= bit_count - 1'b1;
                            end
                        end

                        if (scl_prev && !scl) begin
                            sda_oe  <= 1'b1;
                            sda_out <= tx_shift_reg[bit_count];

                            if (bit_count == 4'd0) begin
                                state <= READ_ACK;
                            end
                        end
                    end

                    // Master ACK/NACK
                    READ_ACK: begin
                        sda_oe <= 1'b0;

                        if (scl_prev && !scl) begin
                            state <= IDLE;
                        end
                    end

                    default: begin
                        state  <= IDLE;
                        sda_oe <= 1'b0;
                    end

                endcase
            end
        end
    end

endmodule