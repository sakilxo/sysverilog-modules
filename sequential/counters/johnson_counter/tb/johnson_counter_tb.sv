`timescale 1ns / 1ps

module johnson_counter_tb;

    logic       clk;
    logic       rst;
    logic [3:0] count;

    johnson_counter dut (

        .clk(clk),
        .rst(rst),
        .count(count)

    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("johnson_counter.vcd");
        $dumpvars(0, johnson_counter_tb);

        clk = 0;
        rst = 1;

        #10;
        rst = 0;

        repeat (16)
            #10;

        rst = 1;
        #10;
        rst = 0;

        repeat (10)
            #10;

        $finish;

    end

endmodule