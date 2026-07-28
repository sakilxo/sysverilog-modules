`timescale 1ns / 1ps

module excess3_to_binary_tb;

    logic [3:0] excess3;
    logic [3:0] binary;

    excess3_to_binary dut (

        .excess3(excess3),
        .binary(binary)

    );

    initial begin

        $dumpfile("excess3_to_binary.vcd");
        $dumpvars(0, excess3_to_binary_tb);

        $display("Excess-3 | Binary");
        $display("-----------------");

        excess3 = 4'b0000;

        repeat (16) begin

            #10;

            $display("%04b     | %04b", excess3, binary);

            excess3 = excess3 + 1'b1;

        end

        $finish;

    end

endmodule