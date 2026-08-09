`timescale 1ns / 1ps

module full_adder (

    input  logic a,
    input  logic b,
    input  logic cin,

    output logic sum,
    output logic cout

);

    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);

endmodule