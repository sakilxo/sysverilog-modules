`timescale 1ns / 1ps

module mux8x1_tb;

    logic d0;
    logic d1;
    logic d2;
    logic d3;
    logic d4;
    logic d5;
    logic d6;
    logic d7;

    logic [2:0] sel;

    logic out;

    mux8x1 dut (
        .d0(d0),
        .d1(d1),
        .d2(d2),
        .d3(d3),
        .d4(d4),
        .d5(d5),
        .d6(d6),
        .d7(d7),
        .sel(sel),
        .out(out)
    );

    initial begin

        $dumpfile("mux8x1.vcd");
        $dumpvars(0, mux8x1_tb);

        $display("SEL D0 D1 D2 D3 D4 D5 D6 D7 | OUT");
        $display("----------------------------------");

        for (int i = 0; i < 2048; i++) begin

            {sel, d0, d1, d2, d3, d4, d5, d6, d7} = i[10:0];

            #10;

            $display("%b  %b  %b  %b  %b  %b  %b  %b  %b | %b",
                     sel,
                     d0,
                     d1,
                     d2,
                     d3,
                     d4,
                     d5,
                     d6,
                     d7,
                     out);
        end

        $finish;

    end

endmodule