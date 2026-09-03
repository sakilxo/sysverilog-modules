
// 1 start bit
// 8 data bits
// 0 parity bits
// 1 stop bit

/*  0 1 0 0 0 0 0 1 0 1
    │ └──────────────┘ │
    │      0x41        │
     start             stop */

`timescale 1ns / 1ps

module uart_tx #(
    parameter integer CLK_FREQ  = 50_000_000,
    parameter integer BAUD_RATE = 115_200
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

    localparam integer COUNTER_WIDTH =
        (BAUD_COUNT <= 1) ? 1 : $clog2(BAUD_COUNT);

    localparam logic [COUNTER_WIDTH-1:0] BAUD_LIMIT =
        COUNTER_WIDTH'(BAUD_COUNT - 1);

    logic [COUNTER_WIDTH-1:0] baud_counter;
    logic [3:0]               bit_index;
    logic [9:0]               tx_shift_reg;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            baud_counter <= '0;
            bit_index    <= 4'd0;
            tx_shift_reg <= 10'b1111111111;
            tx           <= 1'b1;
            busy         <= 1'b0;
            done         <= 1'b0;

        end else begin
            done <= 1'b0;

            if (start && !busy) begin
                // 8-N-1 UART frame
                // stop bit | 8 data bits | start bit
                tx_shift_reg <= {1'b1, data_in, 1'b0};

                baud_counter <= '0;
                bit_index    <= 4'd0;

                tx   <= 1'b0;
                busy <= 1'b1;

            end else if (busy) begin

                if (baud_counter == BAUD_LIMIT) begin
                    baud_counter <= '0;

                    if (bit_index == 4'd9) begin
                        // Transmission complete
                        tx   <= 1'b1;
                        busy <= 1'b0;
                        done <= 1'b1;

                    end else begin
                        bit_index    <= bit_index + 4'd1;
                        tx_shift_reg <= tx_shift_reg >> 1;
                        tx           <= tx_shift_reg[1];
                    end

                end else begin
                    baud_counter <= baud_counter + 1'b1;
                end
            end
        end
    end

endmodule