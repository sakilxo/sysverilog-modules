`timescale 1ns / 1ps

module i2c_slave_tb;

    logic clk;
    logic rst;

    logic scl;

    wire sda;
    logic master_sda;
    logic master_oe;

    logic [7:0] data_in;
    logic [7:0] data_out;
    logic valid;

    assign sda = master_oe ? master_sda : 1'bz;

    i2c_slave #(
        .SLAVE_ADDR(7'h50)
    ) dut (
        .clk      (clk),
        .rst      (rst),
        .scl      (scl),
        .sda      (sda),
        .data_in  (data_in),
        .data_out (data_out),
        .valid    (valid)
    );

    always #5 clk = ~clk;

    task i2c_start;
        begin
            master_oe  = 1'b1;
            master_sda = 1'b1;
            scl        = 1'b1;

            #20;
            master_sda = 1'b0;

            #20;
            scl = 1'b0;
        end
    endtask

    task i2c_stop;
        begin
            master_oe  = 1'b1;
            master_sda = 1'b0;
            scl        = 1'b1;

            #20;
            master_sda = 1'b1;

            #20;
            master_oe = 1'b0;
        end
    endtask

    task send_bit(input logic bit_value);
        begin
            master_oe  = 1'b1;
            master_sda = bit_value;

            #20;
            scl = 1'b1;

            #20;
            scl = 1'b0;
        end
    endtask

    task send_byte(input logic [7:0] byte_value);
        integer i;

        begin
            for (i = 7; i >= 0; i = i - 1)
                send_bit(byte_value[i]);
        end
    endtask

    initial begin
        clk = 1'b0;
        rst = 1'b1;

        scl        = 1'b1;
        master_sda = 1'b1;
        master_oe  = 1'b0;

        data_in = 8'h3C;

        #20;
        rst = 1'b0;

        // START
        i2c_start();

        // Address 0x50 + WRITE = 0xA0
        send_byte(8'hA0);

        // Release SDA so slave can ACK
        master_oe = 1'b0;

        #20;
        scl = 1'b1;

        #20;
        scl = 1'b0;

        // Send data 0xA5
        send_byte(8'hA5);

        // Release SDA for slave ACK
        master_oe = 1'b0;

        #20;
        scl = 1'b1;

        #20;
        scl = 1'b0;

        // STOP
        i2c_stop();

        #40;

        $display("I2C SLAVE RECEIVED = %h", data_out);
        $display("VALID = %b", valid);

        #20;
        $finish;
    end

endmodule