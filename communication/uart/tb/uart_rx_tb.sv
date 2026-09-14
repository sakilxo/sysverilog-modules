`timescale 1ns / 1ps

module uart_rx_tb;

    logic       clk;
    logic       rst;
    logic       rx;

    logic [7:0] data_out;
    logic       valid;
    logic       busy;


    uart_rx #(
        .CLK_FREQ(1_000_000),
        .BAUD_RATE(100_000)
    ) dut (

        .clk(clk),
        .rst(rst),

        .rx(rx),

        .data_out(data_out),
        .valid(valid),
        .busy(busy)

    );


    always #5 clk = ~clk;


    /*
     * Send one UART bit.
     *
     * CLK = 1 MHz
     * BAUD = 100 kHz
     * Therefore:
     *
     * 1 bit = 10 clock cycles
     */
    task send_bit(input logic input_bit);

        begin

            rx = input_bit;

            repeat (10)
                @(posedge clk);

        end

    endtask


    /*
     * Send complete UART frame.
     *
     * 8-N-1:
     *
     * Start = 0
     * Data  = LSB first
     * Stop  = 1
     */
    task send_byte(input logic [7:0] data);

        begin

            // Start bit
            send_bit(1'b0);

            // Data bits
            send_bit(data[0]);
            send_bit(data[1]);
            send_bit(data[2]);
            send_bit(data[3]);
            send_bit(data[4]);
            send_bit(data[5]);
            send_bit(data[6]);
            send_bit(data[7]);

            // Stop bit
            send_bit(1'b1);

        end

    endtask


    initial begin

        $dumpfile("uart_rx.vcd");
        $dumpvars(0, uart_rx_tb);


        clk = 1'b0;
        rst = 1'b1;
        rx  = 1'b1;


        #20;

        rst = 1'b0;


        /*
         * Send 'A'
         *
         * ASCII A = 0x41
         */
        send_byte(8'h41);


        /*
         * Idle
         */
        rx = 1'b1;

        repeat (20)
            @(posedge clk);


        /*
         * Send 'Z'
         *
         * ASCII Z = 0x5A
         */
        send_byte(8'h5A);


        rx = 1'b1;

        repeat (20)
            @(posedge clk);


        $finish;

    end

endmodule