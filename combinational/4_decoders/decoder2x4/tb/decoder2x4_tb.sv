`timescale 1ns / 1ps

module decoder2x4_tb;

    logic [1:0] in;

    logic y0;
    logic y1;
    logic y2;
    logic y3;

    decoder2x4 dut (
        .in(in),
        .y0(y0),
        .y1(y1),
        .y2(y2),
        .y3(y3)
    );

    initial begin

        $dumpfile("decoder2x4.vcd");
        $dumpvars(0, decoder2x4_tb);

        $display("IN | Y0 Y1 Y2 Y3");
        $display("----------------");

        for (int i = 0; i < 4; i++) begin

            in = i[1:0];

            #10;

            $display("%b | %b  %b  %b  %b",
                     in,
                     y0,
                     y1,
                     y2,
                     y3);

        end

        $finish;

    end

endmodule