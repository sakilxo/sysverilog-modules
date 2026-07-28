`timescale 1ns / 1ps

module parameterized_comparator_tb;

    parameter N = 4;

    logic [N-1:0] a;
    logic [N-1:0] b;

    logic gt;
    logic eq;
    logic lt;

    parameterized_comparator #(

        .N(N)

    ) dut (

        .a(a),
        .b(b),
        .gt(gt),
        .eq(eq),
        .lt(lt)

    );

    initial begin

        $dumpfile("parameterized_comparator.vcd");
        $dumpvars(0, parameterized_comparator_tb);

        $display(" A\tB\t| GT EQ LT");
        $display("-------------------------");

        a = 0;  b = 0;  #10;
        $display("%0d\t%0d\t|  %b  %b  %b", a, b, gt, eq, lt);

        a = 3;  b = 5;  #10;
        $display("%0d\t%0d\t|  %b  %b  %b", a, b, gt, eq, lt);

        a = 7;  b = 2;  #10;
        $display("%0d\t%0d\t|  %b  %b  %b", a, b, gt, eq, lt);

        a = 9;  b = 9;  #10;
        $display("%0d\t%0d\t|  %b  %b  %b", a, b, gt, eq, lt);

        a = 15; b = 8;  #10;
        $display("%0d\t%0d\t|  %b  %b  %b", a, b, gt, eq, lt);

        a = 1;  b = 14; #10;
        $display("%0d\t%0d\t|  %b  %b  %b", a, b, gt, eq, lt);

        $finish;

    end

endmodule
