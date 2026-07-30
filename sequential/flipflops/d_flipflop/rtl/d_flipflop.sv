`timescale 1ns / 1ps

module d_flipflop (

    input  logic clk,
    input  logic rst,
    input  logic d,

    output logic q

);

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            q <= 1'b0;
        else
            q <= d;

    end

endmodule