`timescale 1ns / 1ps

module i2c_master_tb;

    logic       clk;
    logic       rst;

    logic       start;
    logic       rw;
    logic [6:0] slave_addr;
    logic [7:0] data_in;

    logic [7:0] data_out;
    logic       busy;
    logic       done;
    logic       ack_error;

    wire sda;
    logic scl;

    logic slave_sda;

    assign sda = slave_sda ? 1'b0 : 1'bz;

    i2c_master #(
        .CLK_DIV(2)
    ) dut (
        .clk        (clk),
        .rst        (rst),
        .start      (start),
        .rw         (rw),
        .slave_addr (slave_addr),
        .data_in    (data_in),
        .data_out   (data_out),
        .busy       (busy),
        .done       (done),
        .ack_error  (ack_error),
        .sda        (sda),
        .scl        (scl)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 1'b0;
        rst = 1'b1;

        start      = 1'b0;
        rw         = 1'b0;
        slave_addr = 7'h50;
        data_in    = 8'hA5;

        slave_sda = 1'b0;

        #20;
        rst = 1'b0;

        // I2C write
        #20;
        start = 1'b1;

        #10;
        start = 1'b0;

        wait (done);

        #20;

        $display("I2C WRITE COMPLETE");
        $display("ACK ERROR = %b", ack_error);

        #20;
        $finish;
    end

endmodule