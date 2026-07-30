`timescale 1ns / 1ps

module register_tb;

    logic clk;
    logic rst;
    logic [7:0] d;
    logic [7:0] q;

    register dut (

        .clk(clk),
        .rst(rst),
        .d(d),
        .q(q)

    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("register.vcd");
        $dumpvars(0, register_tb);

        clk = 0;
        rst = 1;
        d   = 8'h00;

        #10;
        rst = 0;

        d = 8'h12; #10;
        d = 8'hA5; #10;
        d = 8'hFF; #10;
        d = 8'h55; #10;

        rst = 1; #10;
        rst = 0;

        d = 8'h3C; #10;
        d = 8'h81; #10;

        $finish;

    end

endmodule