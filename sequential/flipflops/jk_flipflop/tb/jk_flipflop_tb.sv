`timescale 1ns / 1ps

module jk_flipflop_tb;

    logic clk;
    logic rst;
    logic j;
    logic k;
    logic q;

    jk_flipflop dut (

        .clk(clk),
        .rst(rst),
        .j(j),
        .k(k),
        .q(q)

    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("jk_flipflop.vcd");
        $dumpvars(0, jk_flipflop_tb);

        clk = 1'b0;
        rst = 1'b1;
        j   = 1'b0;
        k   = 1'b0;

        #10;
        rst = 1'b0;

        j = 0; k = 0; #10; // hold

        j = 1; k = 0; #10;  // set

        j = 0; k = 0; #10;  // hold

        j = 0; k = 1; #10;  // reset

        j = 1; k = 1; #10;  // toggle
        j = 1; k = 1; #10;
        j = 1; k = 1; #10;

        j = 0; k = 0; #10;  // hold

        rst = 1; #10;  // reset
        rst = 0;

        j = 1; k = 0; #10;  // set

        $finish;

    end

endmodule