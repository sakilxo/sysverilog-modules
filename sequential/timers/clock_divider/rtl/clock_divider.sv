`timescale 1ns / 1ps

module clock_divider #(

    parameter DIVISOR = 4

)(

    input  logic clk,
    input  logic rst,

    output logic clk_out

);

    logic [$clog2(DIVISOR)-1:0] count;

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            count   <= '0;
            clk_out <= 1'b0;

        end

        else if (count == $clog2(DIVISOR)'(DIVISOR - 1)) begin

            count   <= '0;
            clk_out <= ~clk_out;

        end

        else

            count <= count + 1'b1;

    end

endmodule