`timescale 1ns / 1ps

module logical_right_shifter_tb;

    logic [7:0] data;
    logic [2:0] shift;
    logic [7:0] result;

    logical_right_shifter dut (

        .data(data),
        .shift(shift),
        .result(result)

    );

    initial begin

        $dumpfile("logical_right_shifter.vcd");
        $dumpvars(0, logical_right_shifter_tb);

        $display("   Data   Shift   Result");
        $display("-------------------------");

        data = 8'b11110000;

        shift = 3'd0; #10;
        $display("%08b   %0d    %08b", data, shift, result);

        shift = 3'd1; #10;
        $display("%08b   %0d    %08b", data, shift, result);

        shift = 3'd2; #10;
        $display("%08b   %0d    %08b", data, shift, result);

        shift = 3'd3; #10;
        $display("%08b   %0d    %08b", data, shift, result);

        shift = 3'd4; #10;
        $display("%08b   %0d    %08b", data, shift, result);

        shift = 3'd5; #10;
        $display("%08b   %0d    %08b", data, shift, result);

        shift = 3'd6; #10;
        $display("%08b   %0d    %08b", data, shift, result);

        shift = 3'd7; #10;
        $display("%08b   %0d    %08b", data, shift, result);

        $finish;

    end

endmodule