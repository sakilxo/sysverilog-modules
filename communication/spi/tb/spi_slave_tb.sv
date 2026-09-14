`timescale 1ns / 1ps

module spi_slave_tb;

    logic       clk;
    logic       rst;

    logic       cs;
    logic       sclk;
    logic       mosi;
    logic       miso;

    logic [7:0] data_in;
    logic [7:0] data_out;
    logic       valid;

    spi_slave dut (
        .clk      (clk),
        .rst      (rst),
        .cs       (cs),
        .sclk     (sclk),
        .mosi     (mosi),
        .miso     (miso),
        .data_in  (data_in),
        .data_out (data_out),
        .valid    (valid)
    );

    always #5 clk = ~clk;

    task send_byte(input logic [7:0] tx_data);
        integer i;

        begin
            for (i = 7; i >= 0; i = i - 1) begin
                mosi = tx_data[i];

                // Rising edge: slave samples MOSI
                #20;
                sclk = 1'b1;

                #20;
                sclk = 1'b0;
            end
        end
    endtask

    initial begin
        clk = 1'b0;
        rst = 1'b1;

        cs = 1'b1;
        sclk = 1'b0;
        mosi = 1'b0;

        data_in = 8'h3C;

        #20;
        rst = 1'b0;

        // Select slave
        cs = 1'b0;

        // Send 0xA5
        send_byte(8'hA5);

        #20;

        $display("SPI SLAVE RX = %h", data_out);
        $display("SPI SLAVE TX = %h", data_in);

        // Deselect slave
        cs = 1'b1;

        #20;
        $finish;
    end

endmodule