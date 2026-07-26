`timescale 1ns / 1ps

module comparator1bit_tb;

    logic a;
    logic b;

    logic gt;
    logic eq;
    logic lt;

    comparator1bit dut (

        .a(a),
        .b(b),
        .gt(gt),
        .eq(eq),
        .lt(lt)

    );

    initial begin

        $dumpfile("comparator1bit.vcd");
        $dumpvars(0, comparator1bit_tb);

        $display("A B | GT EQ LT");
        $display("----------------");

        a = 0; b = 0; #10;
        $display("%b %b |  %b  %b  %b", a, b, gt, eq, lt);

        a = 0; b = 1; #10;
        $display("%b %b |  %b  %b  %b", a, b, gt, eq, lt);

        a = 1; b = 0; #10;
        $display("%b %b |  %b  %b  %b", a, b, gt, eq, lt);

        a = 1; b = 1; #10;
        $display("%b %b |  %b  %b  %b", a, b, gt, eq, lt);

        $finish;

    end

endmodule