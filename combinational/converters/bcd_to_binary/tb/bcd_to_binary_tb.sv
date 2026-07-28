`timescale 1ns / 1ps

module bcd_to_binary_tb;

    logic [3:0] bcd;
    logic [3:0] binary;

    bcd_to_binary dut (

        .bcd(bcd),
        .binary(binary)

    );

    initial begin

        $dumpfile("bcd_to_binary.vcd");
        $dumpvars(0, bcd_to_binary_tb);

        $display("BCD  | Binary");
        $display("-------------");

        bcd = 4'b0000;

        repeat (16) begin

            #10;

            $display("%04b | %04b", bcd, binary);

            bcd = bcd + 1'b1;

        end

        $finish;

    end

endmodule