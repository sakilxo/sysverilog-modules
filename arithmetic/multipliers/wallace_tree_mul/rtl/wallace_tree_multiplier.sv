`timescale 1ns / 1ps

module wallace_tree_multiplier (

    input  logic [3:0] a,
    input  logic [3:0] b,

    output logic [7:0] product

);

    logic [3:0] pp0;
    logic [3:0] pp1;
    logic [3:0] pp2;
    logic [3:0] pp3;

    logic s1, s2, s3;
    logic c1, c2, c3;

    logic s4, s5;
    logic c4, c5;

    logic s6;
    logic c6;

    logic [7:0] row0;
    logic [7:0] row1;
    logic [7:0] row2;
    logic [7:0] row3;

    logic [7:0] sum1;
    logic [7:0] carry1;

    logic [7:0] sum2;
    logic [7:0] carry2;

    assign pp0 = a & {4{b[0]}};
    assign pp1 = a & {4{b[1]}};
    assign pp2 = a & {4{b[2]}};
    assign pp3 = a & {4{b[3]}};

    assign row0 = {4'b0000, pp0};
    assign row1 = {3'b000, pp1, 1'b0};
    assign row2 = {2'b00, pp2, 2'b00};
    assign row3 = {1'b0, pp3, 3'b000};


    full_adder fa0 (
        .a(row0[2]),
        .b(row1[2]),
        .cin(row2[2]),
        .sum(sum1[2]),
        .cout(carry1[3])
    );

    full_adder fa1 (
        .a(row0[3]),
        .b(row1[3]),
        .cin(row2[3]),
        .sum(sum1[3]),
        .cout(carry1[4])
    );

    full_adder fa2 (
        .a(row0[4]),
        .b(row1[4]),
        .cin(row2[4]),
        .sum(sum1[4]),
        .cout(carry1[5])
    );

    full_adder fa3 (
        .a(row0[5]),
        .b(row1[5]),
        .cin(row2[5]),
        .sum(sum1[5]),
        .cout(carry1[6])
    );

    assign sum1[0] = row0[0];
    assign sum1[1] = row0[1];

    assign carry1[0] = 1'b0;
    assign carry1[1] = 1'b0;
    assign carry1[2] = 1'b0;
    assign carry1[7] = 1'b0;



    full_adder fa4 (
        .a(sum1[3]),
        .b(carry1[3]),
        .cin(row3[3]),
        .sum(sum2[3]),
        .cout(carry2[4])
    );

    full_adder fa5 (
        .a(sum1[4]),
        .b(carry1[4]),
        .cin(row3[4]),
        .sum(sum2[4]),
        .cout(carry2[5])
    );

    full_adder fa6 (
        .a(sum1[5]),
        .b(carry1[5]),
        .cin(row3[5]),
        .sum(sum2[5]),
        .cout(carry2[6])
    );

    full_adder fa7 (
        .a(sum1[6]),
        .b(carry1[6]),
        .cin(row3[6]),
        .sum(sum2[6]),
        .cout(carry2[7])
    );

    assign sum2[0] = sum1[0];
    assign sum2[1] = sum1[1];
    assign sum2[2] = sum1[2];

    assign carry2[0] = 1'b0;
    assign carry2[1] = 1'b0;
    assign carry2[2] = 1'b0;
    assign carry2[3] = 1'b0;


    logic final_carry;

    assign {final_carry, product} = sum2 + (carry2 << 1);

endmodule