`timescale 1ns / 1ps

module up_counter_tb;

    logic       clk;
    logic       rst;
    logic [7:0] count;

    up_counter dut (

        .clk(clk),
        .rst(rst),
        .count(count)

    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("up_counter.vcd");
        $dumpvars(0, up_counter_tb);

        clk = 0;
        rst = 1;

        #10;
        rst = 0;

        // Count for 20 clock cycles
        repeat (20)
            #10;

        // Reset
        rst = 1;
        #10;
        rst = 0;

        // Count again
        repeat (10)
            #10;

        $finish;

    end

endmodule