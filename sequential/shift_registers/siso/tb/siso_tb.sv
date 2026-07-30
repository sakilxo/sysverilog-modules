`timescale 1ns / 1ps

module siso_tb;

    logic clk;
    logic rst;
    logic serial_in;
    logic serial_out;

    siso dut (

        .clk(clk),
        .rst(rst),
        .serial_in(serial_in),
        .serial_out(serial_out)

    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("siso.vcd");
        $dumpvars(0, siso_tb);

        clk = 0;
        rst = 1;
        serial_in = 0;

        #10;
        rst = 0;

        serial_in = 1; #10;
        serial_in = 0; #10;
        serial_in = 1; #10;
        serial_in = 1; #10;
        serial_in = 0; #10;
        serial_in = 0; #10;
        serial_in = 1; #10;
        serial_in = 0; #10;

        serial_in = 0; #10;  // continue clocking to shift data out
        serial_in = 0; #10;
        serial_in = 0; #10;
        serial_in = 0; #10;
        serial_in = 0; #10;
        serial_in = 0; #10;
        serial_in = 0; #10;
        serial_in = 0; #10;

        $finish;

    end

endmodule