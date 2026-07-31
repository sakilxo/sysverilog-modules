`timescale 1ns / 1ps

module universal_tb;

    logic       clk;
    logic       rst;
    logic [1:0] sel;
    logic       serial_left;
    logic       serial_right;
    logic [7:0] parallel_in;
    logic [7:0] q;

    universal dut (

        .clk(clk),
        .rst(rst),
        .sel(sel),
        .serial_left(serial_left),
        .serial_right(serial_right),
        .parallel_in(parallel_in),
        .q(q)

    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("universal.vcd");
        $dumpvars(0, universal_tb);

        clk = 0;
        rst = 1;
        sel = 2'b00;
        serial_left = 0;
        serial_right = 0;
        parallel_in = 8'b0;

        #10;
        rst = 0;

        sel = 2'b11;  // parallel load
        parallel_in = 8'b10110010;
        #10;

        sel = 2'b00;  // hold
        #10;

        sel = 2'b10;  // shift kleft
        serial_left = 1; #10;
        serial_left = 0; #10;
        serial_left = 1; #10;

        sel = 2'b01;  // shift right
        serial_right = 0; #10;
        serial_right = 1; #10;
        serial_right = 0; #10;

        sel = 2'b11;  // load
        parallel_in = 8'hA5;
        #10;

        rst = 1;  // reset
        #10;
        rst = 0;

        $finish;

    end

endmodule