`timescale 1ns / 1ps

module booth_multiplier_tb;

    parameter WIDTH = 4;

    logic clk;
    logic rst;
    logic start;

    logic signed [WIDTH-1:0] multiplicand;
    logic signed [WIDTH-1:0] multiplier;

    logic signed [(2*WIDTH)-1:0] product;
    logic done;

    booth_multiplier #(
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
        input logic signed [WIDTH-1:0] a,
        input logic signed [WIDTH-1:0] b
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

        $dumpfile("booth_multiplier.vcd");
        $dumpvars(0, booth_multiplier_tb);

        clk = 1'b0;
        rst = 1'b1;
        start = 1'b0;

        multiplicand = '0;
        multiplier   = '0;

        #12;

        rst = 1'b0;

        multiply(4'sd3,  4'sd2);
        multiply(4'sd5,  4'sd4);
        multiply(-4'sd3, 4'sd2);
        multiply(4'sd3, -4'sd2);
        multiply(-4'sd3, -4'sd2);
        multiply(4'sd7, -4'sd4);
        multiply(-4'sd8, 4'sd7);

        #20;

        $finish;

    end

endmodule