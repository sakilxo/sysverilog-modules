`timescale 1ns / 1ps

module parameterized_parity_generator_tb;

    parameter N = 8;

    logic [N-1:0] data;

    logic even_parity;
    logic odd_parity;

    parameterized_parity_generator #(
        .N(N)
    ) dut (
        .data(data),
        .even_parity(even_parity),
        .odd_parity(odd_parity)
    );

    initial begin

        $dumpfile("parameterized_parity_generator.vcd");
        $dumpvars(0, parameterized_parity_generator_tb);

        data = 8'h00; #10;
        data = 8'h01; #10;
        data = 8'h03; #10;
        data = 8'h0F; #10;
        data = 8'h55; #10;
        data = 8'hAA; #10;
        data = 8'hFF; #10;

        $finish;

    end

endmodule