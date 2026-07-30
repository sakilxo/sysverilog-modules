`timescale 1ns / 1ps

module sipo (

    input  logic clk,
    input  logic rst,
    input  logic serial_in,

    output logic [7:0] parallel_out

);

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            parallel_out <= 8'b0;
        else
            parallel_out <= {parallel_out[6:0], serial_in};

    end

endmodule