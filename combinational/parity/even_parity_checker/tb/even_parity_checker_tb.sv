`timescale 1ns / 1ps

module even_parity_checker_tb;

    logic [3:0] data;
    logic parity;
    logic error;

    even_parity_checker dut (
        .data(data),
        .parity(parity),
        .error(error)
    );

    initial begin

        $dumpfile("even_parity_checker.vcd");
        $dumpvars(0, even_parity_checker_tb);

        data = 4'b0000; parity = 0; #10;
        data = 4'b0001; parity = 1; #10;
        data = 4'b0011; parity = 0; #10;
        data = 4'b1111; parity = 0; #10;

        data = 4'b1111; parity = 1; #10;

        $finish;

    end

endmodule