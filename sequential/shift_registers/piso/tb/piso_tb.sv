`timescale 1ns / 1ps

module piso_tb;

    logic       clk;
    logic       rst;
    logic       load;
    logic [7:0] parallel_in;
    logic       serial_out;

    piso dut (

        .clk(clk),
        .rst(rst),
        .load(load),
        .parallel_in(parallel_in),
        .serial_out(serial_out)

    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("piso.vcd");
        $dumpvars(0, piso_tb);

        clk = 0;
        rst = 1;
        load = 0;
        parallel_in = 8'b0;

        #10;
        rst = 0;

        // Load 10110010
        load = 1;
        parallel_in = 8'b10110010;
        #10;

        // Shift it out
        load = 0;

        repeat (8)
            #10;

        $finish;

    end

endmodule