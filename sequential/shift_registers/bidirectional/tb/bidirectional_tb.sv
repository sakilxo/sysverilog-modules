`timescale 1ns / 1ps

module bidirectional_tb;

    logic       clk;
    logic       rst;
    logic       dir;
    logic       serial_in;
    logic [7:0] q;

    bidirectional dut (

        .clk(clk),
        .rst(rst),
        .dir(dir),
        .serial_in(serial_in),
        .q(q)

    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("bidirectional.vcd");
        $dumpvars(0, bidirectional_tb);

        clk = 0;
        rst = 1;
        dir = 0;
        serial_in = 0;

        #10;
        rst = 0;

        dir = 0;  // shifft left

        serial_in = 1; #10;
        serial_in = 0; #10;
        serial_in = 1; #10;
        serial_in = 1; #10;

        dir = 1;  // shift right

        serial_in = 0; #10;
        serial_in = 1; #10;
        serial_in = 0; #10;
        serial_in = 1; #10;

        $finish;

    end

endmodule