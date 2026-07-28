`timescale 1ns / 1ps

module demux1x4_tb;

    logic in;
    logic [1:0] sel;

    logic y0;
    logic y1;
    logic y2;
    logic y3;

    demux1x4 dut (
        .in(in),
        .sel(sel),
        .y0(y0),
        .y1(y1),
        .y2(y2),
        .y3(y3)
    );

    initial begin

        $dumpfile("demux1x4.vcd");
        $dumpvars(0, demux1x4_tb);

        $display("SEL IN | Y0 Y1 Y2 Y3");
        $display("--------------------");

        for (int i = 0; i < 8; i++) begin

            {sel, in} = i[2:0];

            #10;

            $display("%b   %b |  %b  %b  %b  %b",
                     sel,
                     in,
                     y0,
                     y1,
                     y2,
                     y3);

        end

        $finish;

    end

endmodule