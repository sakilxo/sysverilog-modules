
// 1 start bit
// 8 data bits
// 0 parity bits
// 1 stop bit

`timescale 1ns / 1ps

module uart_tx #(
    parameter CLK_FREQ  = 50_000_000,
    parameter BAUD_RATE = 115_200
) (
    input  logic       clk,
    input  logic       rst,

    input  logic       start,
    input  logic [7:0] data_in,

    output logic       tx,
    output logic       busy,
    output logic       done
);

    localparam integer BAUD_COUNT = CLK_FREQ / BAUD_RATE;

    logic [15:0] baud_counter;
    logic [3:0]  bit_index;
    logic [9:0]  tx_shift_reg;


    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            baud_counter <= 16'd0;
            bit_index    <= 4'd0;
            tx_shift_reg <= 10'b1111111111;

            tx   <= 1'b1;
            busy <= 1'b0;
            done <= 1'b0;

        end
        else begin

            done <= 1'b0;


            /*
             * Start transmission
             */
            if (start && !busy) begin

                /*
                 * Frame:
                 *
                 * [9]    Stop bit
                 * [8:1]  Data bits
                 * [0]    Start bit
                 */
                tx_shift_reg <= {
                    1'b1,
                    data_in,
                    1'b0
                };

                baud_counter <= 16'd0;
                bit_index    <= 4'd0;

                tx   <= 1'b0;
                busy <= 1'b1;

            end


            /*
             * Transmission in progress
             */
            else if (busy) begin

                if (baud_counter == BAUD_COUNT - 1) begin

                    baud_counter <= 16'd0;

                    /*
                     * Move to next bit
                     */
                    if (bit_index == 4'd9) begin

                        tx   <= 1'b1;
                        busy <= 1'b0;
                        done <= 1'b1;

                    end
                    else begin

                        bit_index <= bit_index + 1'b1;

                        tx_shift_reg <=
                            tx_shift_reg >> 1;

                        tx <= tx_shift_reg[1];

                    end

                end
                else begin

                    baud_counter <= baud_counter + 1'b1;

                end

            end

        end

    end

endmodule