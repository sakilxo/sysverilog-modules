`timescale 1ns / 1ps

module comparator1bit (

    input  logic a,
    input  logic b,

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