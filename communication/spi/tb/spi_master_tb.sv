`timescale 1ns / 1ps

module spi_master_tb;

    logic       clk;
    logic       rst;
    logic       start;
    logic [7:0] data_in;

    logic [7:0] data_out;
    logic       busy;
    logic       done;

    logic sclk;
    logic mosi;
    logic miso;
    logic cs;

    spi_master #(
        .CLK_DIV(2)
    ) dut (
        .clk      (clk),
        .rst      (rst),
        .start    (start),
        .data_in  (data_in),
        .data_out (data_out),
        .busy     (busy),
        .done     (done),
        .sclk     (sclk),
        .mosi     (mosi),
        .miso     (miso),
        .cs       (cs)
    );

    always #5 clk = ~clk;

    task send_byte(input logic [7:0] rx_data);
        integer i;

        begin
            wait (!cs);

            for (i = 7; i >= 0; i = i - 1) begin
                wait (sclk == 1'b1);
                miso = rx_data[i];

                wait (sclk == 1'b0);
            end
        end
    endtask

    initial begin
        clk = 1'b0;
        rst = 1'b1;
        start = 1'b0;
        data_in = 8'h00;
        miso = 1'b0;

        #20;
        rst = 1'b0;

        // Send 0xA5 and receive 0x3C
        data_in = 8'hA5;
        start = 1'b1;

        #10;
        start = 1'b0;

        send_byte(8'h3C);

        wait (done);

        #20;

        $display("SPI TX = %h", data_in);
        $display("SPI RX = %h", data_out);

        #20;
        $finish;
    end

endmodule