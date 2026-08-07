`timescale 1ns / 1ps

module array_multiplier_tb;

    logic [3:0] a;
    logic [3:0] b;

    logic [7:0] product;

    array_multiplier dut (

        .a(a),
        .b(b),
        .product(product)

    );

    initial begin

        $dumpfile("array_multiplier.vcd");
        $dumpvars(0, array_multiplier_tb);

        a = 4'd0;  b = 4'd0;  #10;
        a = 4'd2;  b = 4'd3;  #10;
        a = 4'd5;  b = 4'd4;  #10;
        a = 4'd7;  b = 4'd6;  #10;
        a = 4'd9;  b = 4'd8;  #10;
        a = 4'd15; b = 4'd15; #10;

        $finish;

    end

endmodule