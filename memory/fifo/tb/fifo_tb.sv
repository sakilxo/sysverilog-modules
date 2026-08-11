`timescale 1ns / 1ps

module fifo_tb;

    parameter DATA_WIDTH = 8;
    parameter DEPTH      = 16;

    logic                  clk;
    logic                  rst;

    logic                  wr_en;
    logic                  rd_en;

    logic [DATA_WIDTH-1:0] write_data;
    logic [DATA_WIDTH-1:0] read_data;

    logic                  full;
    logic                  empty;


    fifo #(
        .DATA_WIDTH(DATA_WIDTH),
        .DEPTH(DEPTH)
    ) dut (

        .clk(clk),
        .rst(rst),

        .wr_en(wr_en),
        .rd_en(rd_en),

        .write_data(write_data),
        .read_data(read_data),

        .full(full),
        .empty(empty)

    );


    always #5 clk = ~clk;


    initial begin

        $dumpfile("fifo.vcd");
        $dumpvars(0, fifo_tb);

        clk = 1'b0;
        rst = 1'b1;

        wr_en = 1'b0;
        rd_en = 1'b0;

        write_data = '0;


        #12;

        rst = 1'b0;


        /*
         * Write 0x11
         */
        @(negedge clk);

        write_data = 8'h11;
        wr_en = 1'b1;

        @(negedge clk);

        wr_en = 1'b0;


        /*
         * Write 0x22
         */
        @(negedge clk);

        write_data = 8'h22;
        wr_en = 1'b1;

        @(negedge clk);

        wr_en = 1'b0;


        /*
         * Write 0x33
         */
        @(negedge clk);

        write_data = 8'h33;
        wr_en = 1'b1;

        @(negedge clk);

        wr_en = 1'b0;


        /*
         * Read 0x11
         */
        @(negedge clk);

        rd_en = 1'b1;

        @(negedge clk);

        rd_en = 1'b0;


        /*
         * Read 0x22
         */
        @(negedge clk);

        rd_en = 1'b1;

        @(negedge clk);

        rd_en = 1'b0;


        /*
         * Read 0x33
         */
        @(negedge clk);

        rd_en = 1'b1;

        @(negedge clk);

        rd_en = 1'b0;


        /*
         * Write several values
         */
        @(negedge clk);

        write_data = 8'hAA;
        wr_en = 1'b1;

        @(negedge clk);

        write_data = 8'hBB;

        @(negedge clk);

        write_data = 8'hCC;

        @(negedge clk);

        wr_en = 1'b0;


        /*
         * Read them back
         */
        @(negedge clk);

        rd_en = 1'b1;

        @(negedge clk);

        rd_en = 1'b0;


        @(negedge clk);

        rd_en = 1'b1;

        @(negedge clk);

        rd_en = 1'b0;


        @(negedge clk);

        rd_en = 1'b1;

        @(negedge clk);

        rd_en = 1'b0;


        #20;

        $finish;

    end

endmodule