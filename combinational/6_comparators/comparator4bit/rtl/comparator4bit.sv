`timescale 1ns / 1ps

module comparator4bit (

    input  logic [3:0] a,
    input  logic [3:0] b,

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