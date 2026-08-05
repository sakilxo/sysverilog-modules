`timescale 1ns / 1ps

module bcd_adder_tb;

    logic [3:0] a;
    logic [3:0] b;
    logic       cin;

    logic [3:0] sum;
    logic       cout;

    bcd_adder dut (

        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)

    );

    initial begin

        $dumpfile("bcd_adder.vcd");
        $dumpvars(0, bcd_adder_tb);

        a = 4'd2; b = 4'd3; cin = 0; #10;   // 5
        a = 4'd4; b = 4'd5; cin = 0; #10;   // 9
        a = 4'd5; b = 4'd6; cin = 0; #10;   // 11
        a = 4'd7; b = 4'd8; cin = 0; #10;   // 15
        a = 4'd9; b = 4'd9; cin = 0; #10;   // 18
        a = 4'd9; b = 4'd9; cin = 1; #10;   // 19

        $finish;

    end

endmodule