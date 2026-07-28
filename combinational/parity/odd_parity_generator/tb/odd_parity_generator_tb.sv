`timescale 1ns / 1ps

module odd_parity_generator_tb;

    logic [3:0] data;
    logic parity;

    odd_parity_generator dut (
        .data(data),
        .parity(parity)
    );

    initial begin

        $dumpfile("odd_parity_generator.vcd");
        $dumpvars(0, odd_parity_generator_tb);

        data = 4'b0000; #10;
        data = 4'b0001; #10;
        data = 4'b0011; #10;
        data = 4'b0111; #10;
        data = 4'b1111; #10;

        $finish;

    end

endmodule