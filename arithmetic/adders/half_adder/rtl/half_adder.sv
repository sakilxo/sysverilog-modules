`timescale 1ns / 1ps

module half_adder (

    input  logic a,
    input  logic b,

    output logic sum,
    output logic carry

);

    assign sum   = a ^ b;
    assign carry = a & b;

endmodule