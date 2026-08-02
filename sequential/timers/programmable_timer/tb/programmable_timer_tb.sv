`timescale 1ns / 1ps

module programmable_timer_tb;

    parameter WIDTH = 8;

    logic             clk;
    logic             rst;
    logic             start;
    logic [WIDTH-1:0] load_value;

    logic             timeout;
    logic [WIDTH-1:0] count;

    programmable_timer #(

        .WIDTH(WIDTH)

    ) dut (

        .clk(clk),
        .rst(rst),
        .start(start),
        .load_value(load_value),
        .timeout(timeout),
        .count(count)

    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("programmable_timer.vcd");
        $dumpvars(0, programmable_timer_tb);

        clk        = 0;
        rst        = 1;
        start      = 0;
        load_value = 0;

        #10;
        rst = 0;

        // Load 10
        load_value = 10;
        start = 1;
        #10;
        start = 0;

        repeat (15)
            #10;

        // Load 5
        load_value = 5;
        start = 1;
        #10;
        start = 0;

        repeat (10)
            #10;

        $finish;

    end

endmodule