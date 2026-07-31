`timescale 1ns / 1ps

module ring_counter_tb;

    logic       clk;
    logic       rst;
    logic [3:0] count;

    ring_counter dut (

        .clk(clk),
        .rst(rst),
        .count(count)

    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("ring_counter.vcd");
        $dumpvars(0, ring_counter_tb);

        clk = 0;
        rst = 1;

        #10;
        rst = 0;

        repeat (12)
            #10;

        rst = 1;
        #10;
        rst = 0;

        repeat (8)
            #10;

        $finish;

    end

endmodule