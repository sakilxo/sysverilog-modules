`timescale 1ns / 1ps

module sipo_tb;

    logic clk;
    logic rst;
    logic serial_in;
    logic [7:0] parallel_out;

    sipo dut (

        .clk(clk),
        .rst(rst),
        .serial_in(serial_in),
        .parallel_out(parallel_out)

    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("sipo.vcd");
        $dumpvars(0, sipo_tb);

        clk = 0;
        rst = 1;
        serial_in = 0;

        #10;
        rst = 0;

        serial_in = 1; #10;  // shift in 10110010
        serial_in = 0; #10;
        serial_in = 1; #10;
        serial_in = 1; #10;
        serial_in = 0; #10;
        serial_in = 0; #10;
        serial_in = 1; #10;
        serial_in = 0; #10;

        #20;

        $finish;

    end

endmodule