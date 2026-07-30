`timescale 1ns / 1ps

module d_flipflop_tb;

    logic clk;
    logic rst;
    logic d;
    logic q;

    d_flipflop dut (

        .clk(clk),
        .rst(rst),
        .d(d),
        .q(q)

    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("d_flipflop.vcd");
        $dumpvars(0, d_flipflop_tb);

        clk = 0;
        rst = 1;
        d = 0;

        #10;
        rst = 0;

        d = 0; #10;
        d = 1; #10;
        d = 0; #10;
        d = 1; #10;

        rst = 1; #10;
        rst = 0;

        d = 1; #10;
        d = 0; #10;

        $finish;

    end

endmodule