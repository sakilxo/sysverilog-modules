`timescale 1ns / 1ps

module up_down_counter_tb;

    logic       clk;
    logic       rst;
    logic       dir;
    logic [7:0] count;

    up_down_counter dut (

        .clk(clk),
        .rst(rst),
        .dir(dir),
        .count(count)

    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("up_down_counter.vcd");
        $dumpvars(0, up_down_counter_tb);

        clk = 0;
        rst = 1;
        dir = 0;

        #10;
        rst = 0;

        // Count Up
        dir = 0;
        repeat (10)
            #10;

        // Count Down
        dir = 1;
        repeat (10)
            #10;

        // Count Up Again
        dir = 0;
        repeat (5)
            #10;

        // Reset
        rst = 1;
        #10;
        rst = 0;

        // Count Down
        dir = 1;
        repeat (8)
            #10;

        $finish;

    end

endmodule