`timescale 1ns / 1ps

module uart_rx #(
    parameter CLK_FREQ  = 50_000_000,
    parameter BAUD_RATE = 115_200
) (
    input  logic       clk,
    input  logic       rst,

    input  logic       rx,

    output logic [7:0] data_out,
    output logic       valid,
    output logic       busy
);

    localparam integer BAUD_COUNT = CLK_FREQ / BAUD_RATE;
    localparam integer HALF_BAUD  = BAUD_COUNT / 2;

    logic [31:0] baud_counter;
    logic [3:0]  bit_index;
    logic [7:0]  rx_shift_reg;

    typedef enum logic [1:0] {
        IDLE,
        START,
        DATA,
        STOP
    } state_t;

    state_t state;


    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            state        <= IDLE;
            baud_counter <= 32'd0;
            bit_index    <= 4'd0;
            rx_shift_reg <= 8'd0;

            data_out <= 8'd0;
            valid    <= 1'b0;
            busy     <= 1'b0;

        end
        else begin

            valid <= 1'b0;


            case (state)

                /*
                 * Waiting for start bit
                 */
                IDLE: begin

                    baud_counter <= 32'd0;
                    bit_index    <= 4'd0;
                    busy         <= 1'b0;

                    if (!rx) begin

                        state        <= START;
                        baud_counter <= 32'd0;
                        busy         <= 1'b1;

                    end

                end


                /*
                 * Verify the start bit at its center
                 */
                START: begin

                    if (baud_counter == HALF_BAUD - 1) begin

                        baud_counter <= 32'd0;

                        if (!rx) begin
                            state <= DATA;
                        end
                        else begin
                            state <= IDLE;
                            busy  <= 1'b0;
                        end

                    end
                    else begin

                        baud_counter <= baud_counter + 1'b1;

                    end

                end


                /*
                 * Receive 8 data bits
                 */
                DATA: begin

                    if (baud_counter == BAUD_COUNT - 1) begin

                        baud_counter <= 32'd0;

                        rx_shift_reg[bit_index[2:0]] <= rx;

                        if (bit_index == 4'd7) begin

                            bit_index <= 4'd0;
                            state     <= STOP;

                        end
                        else begin

                            bit_index <= bit_index + 1'b1;

                        end

                    end
                    else begin

                        baud_counter <= baud_counter + 1'b1;

                    end

                end


                /*
                 * Check stop bit
                 */
                STOP: begin

                    if (baud_counter == BAUD_COUNT - 1) begin

                        baud_counter <= 32'd0;

                        data_out <= rx_shift_reg;
                        valid    <= 1'b1;

                        busy  <= 1'b0;
                        state <= IDLE;

                    end
                    else begin

                        baud_counter <= baud_counter + 1'b1;

                    end

                end


                default: begin

                    state <= IDLE;
                    busy  <= 1'b0;

                end

            endcase

        end

    end

endmodule