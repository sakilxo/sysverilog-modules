`timescale 1ns / 1ps

module carry_save_tb;

    logic [3:0] a;
    logic [3:0] b;
    logic [3:0] c;

    logic [3:0] sum;
    logic [4:0] carry;

    carry_save dut (

        .a(a),
        .b(b),
        .c(c),
        .sum(sum),
        .carry(carry)

    );

    initial begin

        $dumpfile("carry_save.vcd");
        $dumpvars(0, carry_save_tb);

        a = 4'b0000; b = 4'b0000; c = 4'b0000; #10;
        a = 4'b0011; b = 4'b0101; c = 4'b0001; #10;
        a = 4'b0110; b = 4'b0011; c = 4'b0100; #10;
        a = 4'b1111; b = 4'b0001; c = 4'b0010; #10;
        a = 4'b1010; b = 4'b0101; c = 4'b1100; #10;
        a = 4'b1111; b = 4'b1111; c = 4'b1111; #10;

        $finish;

    end

endmodule