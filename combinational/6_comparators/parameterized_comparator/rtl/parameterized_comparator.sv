`timescale 1ns / 1ps

module parameterized_comparator #(

    parameter N = 4

)(

    input  logic [N-1:0] a,
    input  logic [N-1:0] b,

    output logic gt,
    output logic eq,
    output logic lt

);

    always_comb begin

        gt = 1'b0;
        eq = 1'b0;
        lt = 1'b0;

        if (a > b)
            gt = 1'b1;
        else if (a < b)
            lt = 1'b1;
        else
            eq = 1'b1;

    end

endmodule