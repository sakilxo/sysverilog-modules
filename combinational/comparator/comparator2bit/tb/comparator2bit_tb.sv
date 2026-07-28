`timescale 1ns / 1ps

module comparator2bit_tb;

    logic [1:0] a;
    logic [1:0] b;

    logic gt;
    logic eq;
    logic lt;

    comparator2bit dut (

        .a(a),
        .b(b),
        .gt(gt),
        .eq(eq),
        .lt(lt)

    );

    initial begin

        $dumpfile("comparator2bit.vcd");
        $dumpvars(0, comparator2bit_tb);

        $display(" A  B | GT EQ LT");
        $display("----------------");

        a = 2'b00; b = 2'b00; #10;
        $display("%b %b |  %b  %b  %b", a, b, gt, eq, lt);

        a = 2'b00; b = 2'b01; #10;
        $display("%b %b |  %b  %b  %b", a, b, gt, eq, lt);

        a = 2'b01; b = 2'b00; #10;
        $display("%b %b |  %b  %b  %b", a, b, gt, eq, lt);

        a = 2'b10; b = 2'b10; #10;
        $display("%b %b |  %b  %b  %b", a, b, gt, eq, lt);

        a = 2'b11; b = 2'b10; #10;
        $display("%b %b |  %b  %b  %b", a, b, gt, eq, lt);

        a = 2'b01; b = 2'b11; #10;
        $display("%b %b |  %b  %b  %b", a, b, gt, eq, lt);

        $finish;

    end

endmodule