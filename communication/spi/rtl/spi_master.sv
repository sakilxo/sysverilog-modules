`timescale 1ns / 1ps

module spi_master #(
    parameter integer CLK_DIV = 4
) (
    input  logic       clk,
    input  logic       rst,

    input  logic       start,
    input  logic [7:0] data_in,

    output logic [7:0] data_out,
    output logic       busy,
    output logic       done,

    output logic       sclk,
    output logic       mosi,
    input  logic       miso,
    output logic       cs
);

    logic [$clog2(CLK_DIV)-1:0] clk_counter;
    logic [2:0] bit_index;
    logic [7:0] tx_shift_reg;
    logic [7:0] rx_shift_reg;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            clk_counter  <= '0;
            bit_index    <= 3'd7;
            tx_shift_reg <= 8'd0;
            rx_shift_reg <= 8'd0;
            data_out     <= 8'd0;

            busy <= 1'b0;
            done <= 1'b0;

            sclk <= 1'b0;
            mosi <= 1'b0;
            cs   <= 1'b1;
        end else begin
            done <= 1'b0;

            if (!busy) begin
                sclk <= 1'b0;
                cs   <= 1'b1;

                if (start) begin
                    busy        <= 1'b1;
                    cs          <= 1'b0;
                    clk_counter <= '0;
                    bit_index   <= 3'd7;

                    tx_shift_reg <= data_in;
                    rx_shift_reg <= 8'd0;

                    mosi <= data_in[7];
                end
            end else begin

                if (clk_counter == CLK_DIV - 1) begin
                    clk_counter <= '0;

                    sclk <= ~sclk;

                    if (sclk == 1'b0) begin
                        // Rising edge: sample MISO
                        rx_shift_reg[bit_index] <= miso;

                    end else begin
                        // Falling edge: change MOSI
                        if (bit_index == 3'd0) begin
                            busy    <= 1'b0;
                            done    <= 1'b1;
                            cs      <= 1'b1;
                            sclk    <= 1'b0;

                            data_out <= rx_shift_reg;
                            mosi     <= 1'b0;
                        end else begin
                            bit_index <= bit_index - 1'b1;
                            mosi <= tx_shift_reg[bit_index - 1'b1];
                        end
                    end
                end else begin
                    clk_counter <= clk_counter + 1'b1;
                end
            end
        end
    end

endmodule