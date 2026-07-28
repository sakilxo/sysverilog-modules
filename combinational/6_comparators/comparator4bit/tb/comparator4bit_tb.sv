`timescale 1ns / 1ps

module comparator4bit_tb;

    logic [3:0] a;
    logic [3:0] b;

    logic gt;
    logic eq;
    logic lt;

    comparator4bit dut (

        .a(a),
        .b(b),
        .gt(gt),
        .eq(eq),
        .lt(lt)

    );

    initial begin

        $dumpfile("comparator4bit.vcd");
        $dumpvars(0, comparator4bit_tb);

        $display("   A      B | GT EQ LT");
        $display("----------------------");

        a = 4'b0000; b = 4'b0000; #10;
        $display("%b %b |  %b  %b  %b", a, b, gt, eq, lt);

        a = 4'b0011; b = 4'b0101; #10;
        $display("%b %b |  %b  %b  %b", a, b, gt, eq, lt);

        a = 4'b0110; b = 4'b0010; #10;
        $display("%b %b |  %b  %b  %b", a, b, gt, eq, lt);

        a = 4'b1010; b = 4'b1010; #10;
        $display("%b %b |  %b  %b  %b", a, b, gt, eq, lt);

        a = 4'b1111; b = 4'b0111; #10;
        $display("%b %b |  %b  %b  %b", a, b, gt, eq, lt);

        a = 4'b0001; b = 4'b1000; #10;
        $display("%b %b |  %b  %b  %b", a, b, gt, eq, lt);

        a = 4'b1100; b = 4'b1101; #10;
        $display("%b %b |  %b  %b  %b", a, b, gt, eq, lt);

        a = 4'b1111; b = 4'b1111; #10;
        $display("%b %b |  %b  %b  %b", a, b, gt, eq, lt);

        $finish;

    end

endmodule