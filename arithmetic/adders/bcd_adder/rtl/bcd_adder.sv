`timescale 1ns / 1ps

module bcd_adder (

    input  logic [3:0] a,
    input  logic [3:0] b,
    input  logic       cin,

    output logic [3:0] sum,
    output logic       cout

);

    logic [4:0] binary_sum;
    logic [4:0] corrected_sum;

    assign binary_sum = a + b + cin;

    assign corrected_sum =
        (binary_sum > 9) ? (binary_sum + 5'd6) : binary_sum;

    assign sum  = corrected_sum[3:0];
    assign cout = corrected_sum[4];

endmodule