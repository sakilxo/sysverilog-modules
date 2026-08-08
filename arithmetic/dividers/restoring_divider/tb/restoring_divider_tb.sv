`timescale 1ns / 1ps

module restoring_divider_tb;

    parameter WIDTH = 4;

    logic clk;
    logic rst;
    logic start;

    logic [WIDTH-1:0] dividend;
    logic [WIDTH-1:0] divisor;

    logic [WIDTH-1:0] quotient;
    logic [WIDTH-1:0] remainder;

    logic done;

    restoring_divider #(
        .WIDTH(WIDTH)
    ) dut (

        .clk(clk),
        .rst(rst),
        .start(start),

        .dividend(dividend),
        .divisor(divisor),

        .quotient(quotient),
        .remainder(remainder),

        .done(done)

    );

    always #5 clk = ~clk;


    task divide(
        input logic [WIDTH-1:0] a,
        input logic [WIDTH-1:0] b
    );

        begin

            @(negedge clk);

            dividend = a;
            divisor  = b;
            start    = 1'b1;

            @(negedge clk);

            start = 1'b0;

            wait(done);

            #1;

            $display(
                "%0d / %0d = %0d remainder %0d",
                a,
                b,
                quotient,
                remainder
            );

        end

    endtask


    initial begin

        $dumpfile("restoring_divider.vcd");
        $dumpvars(0, restoring_divider_tb);

        clk = 1'b0;
        rst = 1'b1;
        start = 1'b0;

        dividend = '0;
        divisor  = '0;

        #12;

        rst = 1'b0;

        divide(4'd10, 4'd2);
        divide(4'd15, 4'd3);
        divide(4'd13, 4'd4);
        divide(4'd7,  4'd2);
        divide(4'd9,  4'd5);
        divide(4'd15, 4'd4);

        #20;

        $finish;

    end

endmodule