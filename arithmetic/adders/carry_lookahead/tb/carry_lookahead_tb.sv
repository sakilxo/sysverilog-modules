`timescale 1ns / 1ps

module carry_lookahead_adder_tb;

    logic [3:0] a;
    logic [3:0] b;
    logic       cin;

    logic [3:0] sum;
    logic       cout;

    carry_lookahead_adder dut (

        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)

    );

    initial begin

        $dumpfile("carry_lookahead_adder.vcd");
        $dumpvars(0, carry_lookahead_adder_tb);

        a = 4'b0000; b = 4'b0000; cin = 0; #10;
        a = 4'b0011; b = 4'b0101; cin = 0; #10;
        a = 4'b0110; b = 4'b0011; cin = 0; #10;
        a = 4'b1111; b = 4'b0001; cin = 0; #10;
        a = 4'b1010; b = 4'b0101; cin = 1; #10;
        a = 4'b1111; b = 4'b1111; cin = 1; #10;

        $finish;

    end

endmodule