`timescale 1ns / 1ps

module sr_flipflop_tb;

    logic clk;
    logic rst;
    logic s;
    logic r;
    logic q;

    sr_flipflop dut (

        .clk(clk),
        .rst(rst),
        .s(s),
        .r(r),
        .q(q)

    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("sr_flipflop.vcd");
        $dumpvars(0, sr_flipflop_tb);

        clk = 1'b0;
        rst = 1'b1;
        s   = 1'b0;
        r   = 1'b0;

        #10;
        rst = 1'b0;

        s = 0; r = 0; #10;  // hold

        s = 1; r = 0; #10;  // set

        s = 0; r = 0; #10;  // hold

        s = 0; r = 1; #10;  // reset

        s = 0; r = 0; #10;  // hold

        s = 1; r = 1; #10;  // invalud

        rst = 1; #10;  // reset async
        rst = 0;

        s = 1; r = 0; #10;  // set again

        $finish;

    end

endmodule