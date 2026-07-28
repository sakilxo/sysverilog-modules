`timescale 1ns / 1ps

module gray_to_binary_tb;

    logic [3:0] gray;
    logic [3:0] binary;

    gray_to_binary dut (

        .gray(gray),
        .binary(binary)

    );

    initial begin

        $dumpfile("gray_to_binary.vcd");
        $dumpvars(0, gray_to_binary_tb);

        $display(" Gray | Binary");
        $display("----------------");

        gray = 4'b0000; #10;
        $display("%04b | %04b", gray, binary);

        gray = 4'b0001; #10;
        $display("%04b | %04b", gray, binary);

        gray = 4'b0011; #10;
        $display("%04b | %04b", gray, binary);

        gray = 4'b0010; #10;
        $display("%04b | %04b", gray, binary);

        gray = 4'b0110; #10;
        $display("%04b | %04b", gray, binary);

        gray = 4'b0111; #10;
        $display("%04b | %04b", gray, binary);

        gray = 4'b0101; #10;
        $display("%04b | %04b", gray, binary);

        gray = 4'b0100; #10;
        $display("%04b | %04b", gray, binary);

        gray = 4'b1100; #10;
        $display("%04b | %04b", gray, binary);

        gray = 4'b1101; #10;
        $display("%04b | %04b", gray, binary);

        gray = 4'b1111; #10;
        $display("%04b | %04b", gray, binary);

        gray = 4'b1110; #10;
        $display("%04b | %04b", gray, binary);

        gray = 4'b1010; #10;
        $display("%04b | %04b", gray, binary);

        gray = 4'b1011; #10;
        $display("%04b | %04b", gray, binary);

        gray = 4'b1001; #10;
        $display("%04b | %04b", gray, binary);

        gray = 4'b1000; #10;
        $display("%04b | %04b", gray, binary);

        $finish;

    end

endmodule