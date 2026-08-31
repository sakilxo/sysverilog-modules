`timescale 1ns / 1ps

module accumulator_tb;

    parameter WIDTH = 8;

    logic             clk;
    logic             rst;
    logic             enable;
    logic [WIDTH-1:0] data_in;

    logic [WIDTH-1:0] sum;


    accumulator #(
        .WIDTH(WIDTH)
    ) dut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .data_in(data_in),
        .sum(sum)
    );


    always #5 clk = ~clk;


    initial begin

        $dumpfile("accumulator.vcd");
        $dumpvars(0, accumulator_tb);

        clk    = 1'b0;
        rst    = 1'b1;
        enable = 1'b0;
        data_in = '0;

        #12;

        rst = 1'b0;


        // 0 + 10 = 10
        @(negedge clk);
        data_in = 8'd10;
        enable  = 1'b1;

        // 10 + 20 = 30
        @(negedge clk);
        data_in = 8'd20;

        // 30 + 5 = 35
        @(negedge clk);
        data_in = 8'd5;

        // Hold at 35
        @(negedge clk);
        enable = 1'b0;
        data_in = 8'd100;

        // 35 + 15 = 50
        @(negedge clk);
        data_in = 8'd15;
        enable  = 1'b1;

        #20;

        $finish;

    end

endmodule