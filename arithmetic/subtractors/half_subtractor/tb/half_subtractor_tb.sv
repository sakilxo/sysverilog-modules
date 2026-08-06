`timescale 1ns / 1ps

module half_subtractor_tb;

    logic a;
    logic b;

    logic diff;
    logic borrow;

    half_subtractor dut (

        .a(a),
        .b(b),
        .diff(diff),
        .borrow(borrow)

    );

    initial begin

        $dumpfile("half_subtractor.vcd");
        $dumpvars(0, half_subtractor_tb);

        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;

        $finish;

    end

endmodule