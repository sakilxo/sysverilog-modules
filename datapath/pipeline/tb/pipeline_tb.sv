`timescale 1ns / 1ps

module pipeline_tb;

    parameter WIDTH = 8;

    logic             clk;
    logic             rst;
    logic             enable;

    logic [WIDTH-1:0] data_in;
    logic [WIDTH-1:0] data_out;


    pipeline #(
        .WIDTH(WIDTH)
    ) dut (

        .clk(clk),
        .rst(rst),
        .enable(enable),

        .data_in(data_in),
        .data_out(data_out)

    );


    always #5 clk = ~clk;


    initial begin

        $dumpfile("pipeline.vcd");
        $dumpvars(0, pipeline_tb);


        clk     = 1'b0;
        rst     = 1'b1;
        enable  = 1'b0;
        data_in = '0;


        #12;

        rst = 1'b0;
        enable = 1'b1;


        // Input 10
        @(negedge clk);
        data_in = 8'd10;

        // Input 20
        @(negedge clk);
        data_in = 8'd20;

        // Input 30
        @(negedge clk);
        data_in = 8'd30;

        // Input 40
        @(negedge clk);
        data_in = 8'd40;

        // Input 50
        @(negedge clk);
        data_in = 8'd50;


        // Stop input
        @(negedge clk);
        enable = 1'b0;


        #50;

        $finish;

    end

endmodule