`timescale 1ns / 1ps

module mod_n_counter #(

    parameter N = 10

)(

    input  logic clk,
    input  logic rst,

    output logic [$clog2(N)-1:0] count

);

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            count <= '0;

        else if (count == N - 1)
            count <= '0;

        else
            count <= count + 1'b1;

    end

endmodule