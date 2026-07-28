`timescale 1ns/1ps

module parameterized_encoder_tb;

    parameter N = 3;

    logic [(1<<N)-1:0] in;
    logic [N-1:0] out;

    parameterized_encoder #(
        .N(N)
    ) dut (
        .in(in),
        .out(out)
    );

    integer i;

    initial begin
        $dumpfile("parameterized_encoder.vcd");
        $dumpvars(0, parameterized_encoder_tb);

        $display("Input\t\tOutput");

        for (i = 0; i < (1<<N); i = i + 1) begin
            in = 1 << i;
            #10;

            $display("%b\t%b", in, out);
        end

        $finish;
    end

endmodule