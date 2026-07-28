`timescale 1ns / 1ps

module mux4x1_tb;

    logic d0;
    logic d1;
    logic d2;
    logic d3;

    logic [1:0] sel;

    logic out;

    mux4x1 dut (
        .d0(d0),
        .d1(d1),
        .d2(d2),
        .d3(d3),
        .sel(sel),
        .out(out)
    );

    initial begin

        $dumpfile("mux4x1.vcd");
        $dumpvars(0, mux4x1_tb);

        $display("SEL D0 D1 D2 D3 | OUT");
        $display("----------------------");

        for (int i = 0; i < 64; i++) begin

            {sel, d0, d1, d2, d3} = i[5:0];

            #10;

            $display("%b  %b  %b  %b  %b |  %b",
                     sel,
                     d0,
                     d1,
                     d2,
                     d3,
                     out);
        end

        $finish;

    end

endmodule