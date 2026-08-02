`timescale 1ns / 1ps

module clock_divider_tb;

    parameter DIVISOR = 4;

    logic clk;
    logic rst;
    logic clk_out;

    clock_divider #(

        .DIVISOR(DIVISOR)

    ) dut (

        .clk(clk),
        .rst(rst),
        .clk_out(clk_out)

    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("clock_divider.vcd");
        $dumpvars(0, clock_divider_tb);

        clk = 0;
        rst = 1;

        #10;
        rst = 0;

        repeat (40)
            #10;

        rst = 1;
        #10;
        rst = 0;

        repeat (20)
            #10;

        $finish;

    end

endmodule