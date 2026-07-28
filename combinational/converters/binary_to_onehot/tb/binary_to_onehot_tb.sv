`timescale 1ns / 1ps

module binary_to_onehot_tb;

    logic [3:0] binary;
    logic [15:0] onehot;

    binary_to_onehot dut (

        .binary(binary),
        .onehot(onehot)

    );

    initial begin

        $dumpfile("binary_to_onehot.vcd");
        $dumpvars(0, binary_to_onehot_tb);

        $display("Binary | One-Hot");
        $display("----------------------------");

        binary = 4'b0000;

        repeat (16) begin

            #10;

            $display("%04b   | %016b", binary, onehot);

            binary = binary + 1'b1;

        end

        $finish;

    end

endmodule