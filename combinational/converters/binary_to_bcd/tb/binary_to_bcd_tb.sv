`timescale 1ns / 1ps

module binary_to_bcd_tb;

    logic [3:0] binary;

    logic [3:0] tens;
    logic [3:0] ones;

    binary_to_bcd dut (

        .binary(binary),
        .tens(tens),
        .ones(ones)

    );

    initial begin

        $dumpfile("binary_to_bcd.vcd");
        $dumpvars(0, binary_to_bcd_tb);

        $display("Binary | Tens Ones");
        $display("------------------");

        binary = 4'b0000;

        repeat (16) begin

            #10;

            $display("%04b   |  %d    %d", binary, tens, ones);

            binary = binary + 1'b1;

        end

        $finish;

    end

endmodule