`timescale 1ns / 1ps

module encoder4x2_tb;

    logic [3:0] in;
    logic [1:0] out;

    encoder4x2 dut (
        .in(in),
        .out(out)
    );

    initial begin
        $dumpfile("encoder4x2.vcd");
        $dumpvars(0, encoder4x2_tb);

        $display(" Input | Output");
        $display("----------------");

        in = 4'b0001; #10;
        $display("%b | %b", in, out);

        in = 4'b0010; #10;
        $display("%b | %b", in, out);

        in = 4'b0100; #10;
        $display("%b | %b", in, out);

        in = 4'b1000; #10;
        $display("%b | %b", in, out);

        $finish;
    end

endmodule