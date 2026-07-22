`timescale 1ns / 1ps

module parameterized_decoder_tb;

    parameter N = 4;  // [x]: insert some value for N here. eg. 4, 8, 16, etc.

    logic [$clog2(N)-1:0] in;
    logic [N-1:0] out;

    parameterized_decoder #(
        .N(N)
    ) dut (

        .in(in),
        .out(out)

    );

    initial begin

        $dumpfile("parameterized_decoder.vcd");
        $dumpvars(0, parameterized_decoder_tb);

        $display("IN | OUT");
        $display("---------");

        for (int i = 0; i < N; i++) begin

            in = i[$clog2(N)-1:0];

            #10;

            $display("%b | %b", in, out);

        end

        $finish;

    end

endmodule