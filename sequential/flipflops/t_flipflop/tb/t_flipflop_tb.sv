`timescale 1ns / 1ps

module t_flipflop_tb;

    logic clk;
    logic rst;
    logic t;
    logic q;

    t_flipflop dut (

        .clk(clk),
        .rst(rst),
        .t(t),
        .q(q)

    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("t_flipflop.vcd");
        $dumpvars(0, t_flipflop_tb);

        clk = 1'b0;
        rst = 1'b1;
        t   = 1'b0;

        #10;
        rst = 1'b0;

        t = 0; #10;  // hold

        t = 1; #10;  // toggle
        t = 1; #10;
        t = 1; #10;

        t = 0; #10;  // hold

        t = 1; #10;  // toggle
        t = 1; #10;

        rst = 1; #10;  // reset
        rst = 0;

        t = 1; #10;  // toggle

        $finish;

    end

endmodule