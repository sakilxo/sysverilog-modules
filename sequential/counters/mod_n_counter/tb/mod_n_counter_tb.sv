`timescale 1ns / 1ps

module mod_n_counter_tb;

    parameter N = 10;

    logic clk;
    logic rst;
    logic [$clog2(N)-1:0] count;

    mod_n_counter #(

        .N(N)

    ) dut (

        .clk(clk),
        .rst(rst),
        .count(count)

    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("mod_n_counter.vcd");
        $dumpvars(0, mod_n_counter_tb);

        clk = 0;
        rst = 1;

        #10;
        rst = 0;

        repeat (20)
            #10;

        rst = 1;
        #10;
        rst = 0;

        repeat (15)
            #10;

        $finish;

    end

endmodule