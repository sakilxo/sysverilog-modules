`timescale 1ns / 1ps

module encoder8x3_tb;

    logic [7:0] in;
    logic [2:0] out;

    encoder8x3 dut (

        .in(in),
        .out(out)

    );

    initial begin

        $dumpfile("encoder8x3.vcd");
        $dumpvars(0, encoder8x3_tb);

        $display("Input       | Output");
        $display("---------------------");

        in = 8'b00000001; #10;
        $display("%b | %b", in, out);

        in = 8'b00000010; #10;
        $display("%b | %b", in, out);

        in = 8'b00000100; #10;
        $display("%b | %b", in, out);

        in = 8'b00001000; #10;
        $display("%b | %b", in, out);

        in = 8'b00010000; #10;
        $display("%b | %b", in, out);

        in = 8'b00100000; #10;
        $display("%b | %b", in, out);

        in = 8'b01000000; #10;
        $display("%b | %b", in, out);

        in = 8'b10000000; #10;
        $display("%b | %b", in, out);

        $finish;

    end

endmodule