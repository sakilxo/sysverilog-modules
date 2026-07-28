`timescale 1ns / 1ps

module decoder4x16_tb;

    logic [3:0] in;

    logic y0;
    logic y1;
    logic y2;
    logic y3;
    logic y4;
    logic y5;
    logic y6;
    logic y7;
    logic y8;
    logic y9;
    logic y10;
    logic y11;
    logic y12;
    logic y13;
    logic y14;
    logic y15;

    decoder4x16 dut (
        .in(in),
        .y0(y0),
        .y1(y1),
        .y2(y2),
        .y3(y3),
        .y4(y4),
        .y5(y5),
        .y6(y6),
        .y7(y7),
        .y8(y8),
        .y9(y9),
        .y10(y10),
        .y11(y11),
        .y12(y12),
        .y13(y13),
        .y14(y14),
        .y15(y15)
    );

    initial begin

        $dumpfile("decoder4x16.vcd");
        $dumpvars(0, decoder4x16_tb);

        $display("IN   | Active Output");
        $display("--------------------");

        for (int i = 0; i < 16; i++) begin

            in = i[3:0];

            #10;

            $display("%b | %b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b",
                in,
                y15, y14, y13, y12,
                y11, y10, y9, y8,
                y7, y6, y5, y4,
                y3, y2, y1, y0);

        end

        $finish;

    end

endmodule