`timescale 1ns / 1ps

module ram_tb;

    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 4;

    logic                  clk;
    logic                  we;

    logic [ADDR_WIDTH-1:0] addr;
    logic [DATA_WIDTH-1:0] write_data;

    logic [DATA_WIDTH-1:0] read_data;


    ram #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) dut (

        .clk(clk),
        .we(we),

        .addr(addr),
        .write_data(write_data),

        .read_data(read_data)

    );


    always #5 clk = ~clk;


    initial begin

        $dumpfile("ram.vcd");
        $dumpvars(0, ram_tb);


        clk = 1'b0;
        we  = 1'b0;

        addr      = '0;
        write_data = '0;


        @(negedge clk);  // write 0xAA to address 0

        addr       = 4'd0;
        write_data = 8'hAA;
        we         = 1'b1;

        @(negedge clk);

        we = 1'b0;


        addr = 4'd0;  // read address 0

        #10;


        @(negedge clk);  // write 0x55 to address 5

        addr       = 4'd5;
        write_data = 8'h55;
        we         = 1'b1;

        @(negedge clk);

        we = 1'b0;


        addr = 4'd5;  // read address 5

        #10;



        @(negedge clk);  // write 0x11 to address 1, 0x22 to address 2, and 0x33 to address 3

        addr       = 4'd1;
        write_data = 8'h11;
        we         = 1'b1;

        @(negedge clk);

        addr       = 4'd2;
        write_data = 8'h22;

        @(negedge clk);

        addr       = 4'd3;
        write_data = 8'h33;

        @(negedge clk);

        we = 1'b0;



        addr = 4'd1;  // read address 1
        #10;

        addr = 4'd2;  // read address 2
        #10;

        addr = 4'd3;  // read address 3
        #10;


        $finish;  

    end

endmodule