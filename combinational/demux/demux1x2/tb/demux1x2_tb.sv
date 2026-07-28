`timescale 1ns / 1ps

module demux1x2_tb;

    logic in;
    logic sel;

    logic y0;
    logic y1;

    demux1x2 dut (
        .in(in),
        .sel(sel),
        .y0(y0),
        .y1(y1)
    );

    initial begin

        $dumpfile("demux1x2.vcd");
        $dumpvars(0, demux1x2_tb);

        $display("SEL IN | Y0 Y1");
        $display("--------------");

        for (int i = 0; i < 4; i++) begin

            {sel, in} = i[1:0];

            #10;

            $display("%b   %b | %b  %b",
                     sel,
                     in,
                     y0,
                     y1);

        end

        $finish;

    end

endmodule