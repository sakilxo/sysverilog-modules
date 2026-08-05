`timescale 1ns / 1ps

module carry_select (

    input  logic [3:0] a,
    input  logic [3:0] b,
    input  logic       cin,

    output logic [3:0] sum,
    output logic       cout

);

    logic [3:0] sum0;
    logic [3:0] sum1;

    logic cout0;
    logic cout1;

    ripple_carry rca0 (

        .a(a),
        .b(b),
        .cin(1'b0),
        .sum(sum0),
        .cout(cout0)

    );

    ripple_carry rca1 (

        .a(a),
        .b(b),
        .cin(1'b1),
        .sum(sum1),
        .cout(cout1)

    );

    assign sum  = (cin) ? sum1 : sum0;
    assign cout = (cin) ? cout1 : cout0;

endmodule