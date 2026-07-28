`timescale 1ns / 1ps

module priority_encoder8x3_tb;

    logic [7:0] in;

    logic [2:0] out;
    logic valid;

    priority_encoder8x3 dut (

        .in(in),
        .out(out),
        .valid(valid)

    );

    initial begin

        $dumpfile("priority_encoder8x3.vcd");
        $dumpvars(0, priority_encoder8x3_tb);

        $display("Input      | Valid | Output");
        $display("---------------------------");

        in = 8'b00000000; #10;
        $display("%b |   %b   | %b", in, valid, out);

        in = 8'b00000001; #10;
        $display("%b |   %b   | %b", in, valid, out);

        in = 8'b00000100; #10;
        $display("%b |   %b   | %b", in, valid, out);

        in = 8'b00011000; #10;
        $display("%b |   %b   | %b", in, valid, out);

        in = 8'b01101000; #10;
        $display("%b |   %b   | %b", in, valid, out);

        in = 8'b11111111; #10;
        $display("%b |   %b   | %b", in, valid, out);

        $finish;

    end

endmodule