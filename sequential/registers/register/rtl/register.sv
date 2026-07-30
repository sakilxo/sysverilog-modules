`timescale 1ns / 1ps

module register (

    input logic clk,
    input logic rst,
    input logic [7:0] d,

    output logic [7:0] q

);

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            q <= 8'b0;
        else
            q <= d;

    end

endmodule