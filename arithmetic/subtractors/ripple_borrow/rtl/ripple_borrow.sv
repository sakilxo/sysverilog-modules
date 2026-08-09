`timescale 1ns / 1ps

module ripple_borrow (

    input  logic [3:0] a,
    input  logic [3:0] b,
    input  logic       bin,

    output logic [3:0] diff,
    output logic       bout

);

    logic b1;
    logic b2;
    logic b3;

    full_subtractor fs0 (

        .a(a[0]),
        .b(b[0]),
        .bin(bin),
        .diff(diff[0]),
        .bout(b1)

    );

    full_subtractor fs1 (

        .a(a[1]),
        .b(b[1]),
        .bin(b1),
        .diff(diff[1]),
        .bout(b2)

    );

    full_subtractor fs2 (

        .a(a[2]),
        .b(b[2]),
        .bin(b2),
        .diff(diff[2]),
        .bout(b3)

    );

    full_subtractor fs3 (

        .a(a[3]),
        .b(b[3]),
        .bin(b3),
        .diff(diff[3]),
        .bout(bout)

    );

endmodule