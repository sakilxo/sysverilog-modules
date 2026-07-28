`timescale 1ns / 1ps

module even_parity_generator_tb;

    logic [3:0] data;
    logic parity;

    even_parity_generator dut (

        .data(data),
        .parity(parity)

    );

    initial begin

        $dumpfile("even_parity_generator.vcd");
        $dumpvars(0, even_parity_generator_tb);

        $display("Data  Parity");
        $display("------------");

        data = 4'b0000; #10;
        $display("%b    %b", data, parity);

        data = 4'b0001; #10;
        $display("%b    %b", data, parity);

        data = 4'b0011; #10;
        $display("%b    %b", data, parity);

        data = 4'b0111; #10;
        $display("%b    %b", data, parity);

        data = 4'b1111; #10;
        $display("%b    %b", data, parity);

        $finish;

    end

endmodule