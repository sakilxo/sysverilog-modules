`timescale 1ns / 1ps

module down_counter_tb;

    logic       clk;
    logic       rst;
    logic [7:0] count;

    down_counter dut (

        .clk(clk),
        .rst(rst),
        .count(count)

    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("down_counter.vcd");
        $dumpvars(0, down_counter_tb);

        clk = 0;
        rst = 1;

        #10;
        rst = 0;

        repeat (20)
            #10;

        rst = 1;
        #10;
        rst = 0;

        repeat (10)
            #10;

        $finish;

    end

endmodule