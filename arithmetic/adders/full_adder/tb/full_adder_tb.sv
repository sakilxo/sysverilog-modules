`timescale 1ns / 1ps

module full_adder_tb;

    logic a;
    logic b;
    logic cin;

    logic sum;
    logic cout;

    full_adder dut (

        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)

    );

    initial begin

        $dumpfile("full_adder.vcd");
        $dumpvars(0, full_adder_tb);

        a = 0; b = 0; cin = 0; #10;
        a = 0; b = 0; cin = 1; #10;
        a = 0; b = 1; cin = 0; #10;
        a = 0; b = 1; cin = 1; #10;
        a = 1; b = 0; cin = 0; #10;
        a = 1; b = 0; cin = 1; #10;
        a = 1; b = 1; cin = 0; #10;
        a = 1; b = 1; cin = 1; #10;

        $finish;

    end

endmodule