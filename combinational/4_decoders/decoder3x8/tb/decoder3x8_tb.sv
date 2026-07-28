`timescale 1ns / 1ps

module decoder3x8_tb;

    logic [2:0] in;

    logic y0;
    logic y1;
    logic y2;
    logic y3;
    logic y4;
    logic y5;
    logic y6;
    logic y7;

    decoder3x8 dut (
        .in(in),
        .y0(y0),
        .y1(y1),
        .y2(y2),
        .y3(y3),
        .y4(y4),
        .y5(y5),
        .y6(y6),
        .y7(y7)
    );

    initial begin

        $dumpfile("decoder3x8.vcd");
        $dumpvars(0, decoder3x8_tb);

        $display("IN  | Y0 Y1 Y2 Y3 Y4 Y5 Y6 Y7");
        $display("-----------------------------");

        for (int i = 0; i < 8; i++) begin

            in = i[2:0];

            #10;

            $display("%b | %b  %b  %b  %b  %b  %b  %b  %b",
                     in,
                     y0,
                     y1,
                     y2,
                     y3,
                     y4,
                     y5,
                     y6,
                     y7);

        end

        $finish;

    end

endmodule