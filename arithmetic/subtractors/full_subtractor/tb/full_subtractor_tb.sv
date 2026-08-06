`timescale 1ns / 1ps

module full_subtractor_tb;

    logic a;
    logic b;
    logic bin;

    logic diff;
    logic bout;

    full_subtractor dut (

        .a(a),
        .b(b),
        .bin(bin),
        .diff(diff),
        .bout(bout)

    );

    initial begin

        $dumpfile("full_subtractor.vcd");
        $dumpvars(0, full_subtractor_tb);

        a = 0; b = 0; bin = 0; #10;
        a = 0; b = 0; bin = 1; #10;
        a = 0; b = 1; bin = 0; #10;
        a = 0; b = 1; bin = 1; #10;
        a = 1; b = 0; bin = 0; #10;
        a = 1; b = 0; bin = 1; #10;
        a = 1; b = 1; bin = 0; #10;
        a = 1; b = 1; bin = 1; #10;

        $finish;

    end

endmodule