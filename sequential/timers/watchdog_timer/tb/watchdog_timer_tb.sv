`timescale 1ns / 1ps

module watchdog_timer_tb;

    parameter WIDTH   = 8;
    parameter TIMEOUT = 10;

    logic clk;
    logic rst;
    logic feed;

    logic timeout;
    logic [WIDTH-1:0] count;

    watchdog_timer #(

        .WIDTH(WIDTH),
        .TIMEOUT(TIMEOUT)

    ) dut (

        .clk(clk),
        .rst(rst),
        .feed(feed),
        .timeout(timeout),
        .count(count)

    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("watchdog_timer.vcd");
        $dumpvars(0, watchdog_timer_tb);

        clk  = 0;
        rst  = 1;
        feed = 0;

        #10;
        rst = 0;

        // Feed before timeout
        repeat (5)
            #10;

        feed = 1;
        #10;
        feed = 0;

        // Feed again
        repeat (7)
            #10;

        feed = 1;
        #10;
        feed = 0;

        // Don't feed -> timeout occurs
        repeat (15)
            #10;

        $finish;

    end

endmodule