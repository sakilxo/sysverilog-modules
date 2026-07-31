`timescale 1ns / 1ps

module pipo_tb;

    logic clk;
    logic rst;
    logic [7:0] parallel_in;
    logic [7:0] parallel_out;

    pipo dut (

        .clk(clk),
        .rst(rst),
        .parallel_in(parallel_in),
        .parallel_out(parallel_out)

    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("pipo.vcd");
        $dumpvars(0, pipo_tb);

        clk = 0;
        rst = 1;
        parallel_in = 8'h00;

        #10;
        rst = 0;

        parallel_in = 8'h12; #10;
        parallel_in = 8'hA5; #10;
        parallel_in = 8'hFF; #10;
        parallel_in = 8'h3C; #10;

        rst = 1; #10;
        rst = 0;

        parallel_in = 8'h81; #10;
        parallel_in = 8'h55; #10;

        $finish;

    end

endmodule