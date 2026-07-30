`timescale 1ns / 1ps

module register_file_tb;

    logic       clk;
    logic       rst;
    logic       we;
    logic [2:0] waddr;
    logic [2:0] raddr;
    logic [7:0] wdata;
    logic [7:0] rdata;

    register_file dut (

        .clk(clk),
        .rst(rst),
        .we(we),
        .waddr(waddr),
        .raddr(raddr),
        .wdata(wdata),
        .rdata(rdata)

    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("register_file.vcd");
        $dumpvars(0, register_file_tb);

        clk   = 0;
        rst   = 1;
        we    = 0;
        waddr = 0;
        raddr = 0;
        wdata = 0;

        #10;
        rst = 0;

        we = 1;  // write 0x12 to R0
        waddr = 3'd0;
        wdata = 8'h12;
        #10;

        waddr = 3'd3;  // write 0xA5 to R3
        wdata = 8'hA5;
        #10;

        waddr = 3'd7;  // write 0xFF to R7
        wdata = 8'hFF;
        #10;

        we = 0;

        raddr = 3'd0;  //read R0
        #10;

        raddr = 3'd3;  // read R3
        #10;

        raddr = 3'd7;  // read R7
        #10;

        rst = 1;  // reset all registers
        #10;
        rst = 0;

        raddr = 3'd7;  // read R7 after reset
        #10;

        $finish;

    end

endmodule