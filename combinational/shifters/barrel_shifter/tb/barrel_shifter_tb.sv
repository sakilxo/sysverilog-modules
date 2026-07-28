`timescale 1ns / 1ps

module barrel_shifter_tb;

    logic [7:0] data;
    logic [2:0] shift;
    logic       dir;
    logic [7:0] result;

    barrel_shifter dut (

        .data(data),
        .shift(shift),
        .dir(dir),
        .result(result)

    );

    initial begin

        $dumpfile("barrel_shifter.vcd");
        $dumpvars(0, barrel_shifter_tb);

        $display("   Data   Dir Shift   Result");
        $display("----------------------------");

        data = 8'b10110011;

        // Left shifts
        dir = 1'b0;
        shift = 3'd0; #10;
        $display("%08b   %b    %0d    %08b", data, dir, shift, result);

        shift = 3'd1; #10;
        $display("%08b   %b    %0d    %08b", data, dir, shift, result);

        shift = 3'd2; #10;
        $display("%08b   %b    %0d    %08b", data, dir, shift, result);

        shift = 3'd3; #10;
        $display("%08b   %b    %0d    %08b", data, dir, shift, result);

        // Right shifts
        dir = 1'b1;

        shift = 3'd0; #10;
        $display("%08b   %b    %0d    %08b", data, dir, shift, result);

        shift = 3'd1; #10;
        $display("%08b   %b    %0d    %08b", data, dir, shift, result);

        shift = 3'd2; #10;
        $display("%08b   %b    %0d    %08b", data, dir, shift, result);

        shift = 3'd3; #10;
        $display("%08b   %b    %0d    %08b", data, dir, shift, result);

        $finish;

    end

endmodule