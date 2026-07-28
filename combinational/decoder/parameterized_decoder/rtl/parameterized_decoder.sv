`timescale 1ns / 1ps

module parameterized_decoder #(

    parameter N = x // [x]: insert some value for N here. eg. 4, 8, 16, etc.

)(

    input  logic [$clog2(N)-1:0] in,
    output logic [N-1:0] out

);

    always_comb begin

        out = '0;
        out[in] = 1'b1;

    end

endmodule