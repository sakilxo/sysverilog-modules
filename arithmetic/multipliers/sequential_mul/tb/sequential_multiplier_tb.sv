`timescale 1ns / 1ps

module sequential_multiplier_tb;

    parameter WIDTH = 4;

    logic clk;
    logic rst;
    logic start;

    logic [WIDTH-1:0] multiplicand;
    logic [WIDTH-1:0] multiplier;

    logic [(2*WIDTH)-1:0] product;
    logic done;

    sequential_multiplier #(
        .WIDTH(WIDTH)
    ) dut (

        .clk(clk),
        .rst(rst),
        .start(start),

        .multiplicand(multiplicand),
        .multiplier(multiplier),

        .product(product),
        .done(done)

    );

    always #5 clk = ~clk;


    task multiply(
        input logic [WIDTH-1:0] a,
        input logic [WIDTH-1:0] b
    );

        begin

            @(negedge clk);

            multiplicand = a;
            multiplier   = b;
            start        = 1'b1;

            @(negedge clk);

            start = 1'b0;

            wait(done);

            #1;

            $display(
                "%0d x %0d = %0d",
                a,
                b,
                product
            );

        end

    endtask


    initial begin

        $dumpfile("sequential_multiplier.vcd");
        $dumpvars(0, sequential_multiplier_tb);

        clk = 1'b0;
        rst = 1'b1;
        start = 1'b0;

        multiplicand = '0;
        multiplier   = '0;

        #12;

        rst = 1'b0;

        multiply(4'd2,  4'd3);
        multiply(4'd5,  4'd4);
        multiply(4'd7,  4'd6);
        multiply(4'd9,  4'd8);
        multiply(4'd12, 4'd13);
        multiply(4'd15, 4'd15);

        #20;

        $finish;

    end

endmodule