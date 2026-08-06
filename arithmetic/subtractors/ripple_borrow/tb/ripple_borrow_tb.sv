`timescale 1ns / 1ps

module ripple_borrow_tb;

    logic [3:0] a;
    logic [3:0] b;
    logic       bin;

    logic [3:0] diff;
    logic       bout;

    ripple_borrow dut (

        .a(a),
        .b(b),
        .bin(bin),
        .diff(diff),
        .bout(bout)

    );

    initial begin

        $dumpfile("ripple_borrow.vcd");
        $dumpvars(0, ripple_borrow_tb);

        a = 4'b0101; b = 4'b0011; bin = 0; #10;
        a = 4'b0110; b = 4'b0101; bin = 0; #10;
        a = 4'b1000; b = 4'b0011; bin = 0; #10;
        a = 4'b0011; b = 4'b0101; bin = 0; #10;
        a = 4'b1111; b = 4'b0001; bin = 1; #10;
        a = 4'b0000; b = 4'b0001; bin = 0; #10;

        $finish;

    end

endmodule