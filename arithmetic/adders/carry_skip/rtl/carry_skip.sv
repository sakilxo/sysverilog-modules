`timescale 1ns / 1ps

module carry_skip (

    input  logic [3:0] a,
    input  logic [3:0] b,
    input  logic       cin,

    output logic [3:0] sum,
    output logic       cout

);

    logic c1;
    logic c2;
    logic c3;
    logic c4;

    logic [3:0] p;
    logic       block_propagate;

    assign p = a ^ b;

    assign block_propagate = &p;

    full_adder fa0 (

        .a(a[0]),
        .b(b[0]),
        .cin(cin),
        .sum(sum[0]),
        .cout(c1)

    );

    full_adder fa1 (

        .a(a[1]),
        .b(b[1]),
        .cin(c1),
        .sum(sum[1]),
        .cout(c2)

    );

    full_adder fa2 (

        .a(a[2]),
        .b(b[2]),
        .cin(c2),
        .sum(sum[2]),
        .cout(c3)

    );

    full_adder fa3 (

        .a(a[3]),
        .b(b[3]),
        .cin(c3),
        .sum(sum[3]),
        .cout(c4)

    );

    assign cout = block_propagate ? cin : c4;

endmodule