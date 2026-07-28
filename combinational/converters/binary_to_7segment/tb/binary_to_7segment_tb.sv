`timescale 1ns / 1ps

module binary_to_seven_segment_tb;

    logic [3:0] binary;
    logic [6:0] segments;

    binary_to_seven_segment dut (

        .binary(binary),
        .segments(segments)

    );

    initial begin

        $dumpfile("binary_to_seven_segment.vcd");
        $dumpvars(0, binary_to_seven_segment_tb);

        $display("Binary | Segments");
        $display("-----------------");

        binary = 4'b0000;

        repeat (16) begin

            #10;

            $display("%04b   | %07b", binary, segments);

            binary = binary + 1'b1;

        end

        $finish;

    end

endmodule