`timescale 1ns / 1ps

module binary_to_excess3_tb;

    logic [3:0] binary;
    logic [3:0] excess3;

    binary_to_excess3 dut (

        .binary(binary),
        .excess3(excess3)

    );

    initial begin

        $dumpfile("binary_to_excess3.vcd");
        $dumpvars(0, binary_to_excess3_tb);

        $display("Binary | Excess-3");
        $display("-----------------");

        binary = 4'b0000;

        repeat (16) begin

            #10;

            $display("%04b   | %04b", binary, excess3);

            binary = binary + 1'b1;

        end

        $finish;

    end

endmodule