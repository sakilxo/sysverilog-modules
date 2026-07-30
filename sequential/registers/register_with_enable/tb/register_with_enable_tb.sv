`timescale 1ns / 1ps

module register_with_enable_tb;

    logic       clk;
    logic       rst;
    logic       en;
    logic [7:0] d;
    logic [7:0] q;

    register_with_enable dut (

        .clk(clk),
        .rst(rst),
        .en(en),
        .d(d),
        .q(q)

    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("register_with_enable.vcd");
        $dumpvars(0, register_with_enable_tb);

        clk = 0;
        rst = 1;
        en  = 0;
        d   = 8'h00;

        #10;
        rst = 0;

        // Load 0x12
        en = 1;
        d  = 8'h12;
        #10;

        // Hold
        en = 0;
        d  = 8'hA5;
        #10;

        // Load 0xA5
        en = 1;
        #10;

        // Hold
        en = 0;
        d  = 8'hFF;
        #10;

        // Load 0xFF
        en = 1;
        #10;

        // Reset
        rst = 1;
        #10;
        rst = 0;

        // Load 0x3C
        en = 1;
        d  = 8'h3C;
        #10;

        $finish;

    end

endmodule