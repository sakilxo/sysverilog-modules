module arithmetic_right_shift_tb;

    parameter WIDTH = 8;

    logic [WIDTH-1:0] data_in;
    logic [$clog2(WIDTH)-1:0] shift_amount;
    logic [WIDTH-1:0] data_out;

    arithmetic_right_shift #(
        .WIDTH(WIDTH)
    ) dut (
        .data_in(data_in),
        .shift_amount(shift_amount),
        .data_out(data_out)
    );


    initial begin
        $dumpfile("arithmetic_right_shift.vcd");
        $dumpvars(0, arithmetic_right_shift_tb);

        // Positive number
        data_in = 8'b01000000; // 64
        shift_amount = 2;
        #10;

        // Negative number (two's complement)
        data_in = 8'b11000000; // -64
        shift_amount = 2;
        #10;

        // Shift by 1
        data_in = 8'b11110000; // -16
        shift_amount = 1;
        #10;

        $finish;
    end

endmodule