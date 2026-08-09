`timescale 1ns / 1ps

module carry_save (

    input  logic [3:0] a,
    input  logic [3:0] b,
    input  logic [3:0] c,

    output logic [3:0] sum,
    output logic [4:0] carry

);

    logic c0, c1, c2, c3;

    full_adder fa0 (

        .a(a[0]),
        .b(b[0]),
        .cin(c[0]),
        .sum(sum[0]),
        .cout(c0)

    );

    full_adder fa1 (

        .a(a[1]),
        .b(b[1]),
        .cin(c[1]),
        .sum(sum[1]),
        .cout(c1)

    );

    full_adder fa2 (

        .a(a[2]),
        .b(b[2]),
        .cin(c[2]),
        .sum(sum[2]),
        .cout(c2)

    );

    full_adder fa3 (

        .a(a[3]),
        .b(b[3]),
        .cin(c[3]),
        .sum(sum[3]),
        .cout(c3)

    );

    assign carry = {c3, c2, c1, c0, 1'b0};

endmodule