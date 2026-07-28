`timescale 1ns / 1ps

module binary_to_gray_tb;

    logic [3:0] binary;
    logic [3:0] gray;

    binary_to_gray dut (

        .binary(binary),
        .gray(gray)

    );

    initial begin

        $dumpfile("binary_to_gray.vcd");
        $dumpvars(0, binary_to_gray_tb);

        $display("Binary | Gray");
        $display("--------------");

        binary = 4'b0000;

        repeat (16) begin

            #10;

            $display("%04b   | %04b", binary, gray);

            binary = binary + 1'b1;

        end

        $finish;

    end

endmodule