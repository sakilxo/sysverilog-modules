`timescale 1ns / 1ps

module rom_tb;

    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 4;

    logic [ADDR_WIDTH-1:0] addr;
    logic [DATA_WIDTH-1:0] data;

    rom #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) dut (
        .addr(addr),
        .data(data)
    );

    initial begin

        $dumpfile("rom.vcd");
        $dumpvars(0, rom_tb);

        addr = 4'd0;  #10;
        addr = 4'd1;  #10;
        addr = 4'd2;  #10;
        addr = 4'd3;  #10;
        addr = 4'd4;  #10;
        addr = 4'd5;  #10;
        addr = 4'd10; #10;
        addr = 4'd15; #10;

        $finish;

    end

endmodule