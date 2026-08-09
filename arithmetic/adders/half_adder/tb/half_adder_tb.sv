`timescale 1ns / 1ps

module half_adder_tb;

    logic a;
    logic b;

    logic sum;
    logic carry;

    half_adder dut (

        .a(a),
        .b(b),
        .sum(sum),
        .carry(carry)

    );

    initial begin

        $dumpfile("half_adder.vcd");
        $dumpvars(0, half_adder_tb);

        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;

        $finish;

    end

endmodule