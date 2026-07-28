`timescale 1ns / 1ps

module logic_gates (
    input logic a,
    input logic b,

    output logic and_out,
    output logic or_out,
    output logic xor_out,
    output logic xnor_out,
    output logic nand_out,
    output logic nor_out,
    output logic not_a_out,
    output logic not_b_out
);


    assign and_out = a & b;
    assign or_out = a | b;
    assign xor_out = a ^ b;
    assign xnor_out = ~(a ^ b);
    assign nand_out = ~(a & b);
    assign nor_out = ~(a | b);
    assign not_a_out = ~a;
    assign not_b_out = ~b;

endmodule