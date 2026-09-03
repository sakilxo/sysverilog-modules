`timescale 1ns/1ps

module uart_tx_tb;

    logic       clk;
    logic       rst;
    logic       start;
    logic [7:0] data_in;

    logic       tx;
    logic       busy;
    logic       done;

    uart_tx #(
        .CLK_FREQ(1_000_000),
        .BAUD_RATE(100_000)
    ) dut (
        .clk      (clk),
        .rst      (rst),
        .start    (start),
        .data_in  (data_in),
        .tx       (tx),
        .busy     (busy),
        .done     (done)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("uart_tx.vcd");
        $dumpvars(0, uart_tx_tb);

        clk     = 1'b0;
        rst     = 1'b1;
        start   = 1'b0;
        data_in = 8'h00;

        #20;
        rst = 1'b0;

        // Send 'A'
        #20;
        data_in = 8'h41;
        start   = 1'b1;

        #10;
        start = 1'b0;

        wait(done);

        #50;

        // Send 'Z'
        data_in = 8'h5A;
        start   = 1'b1;

        #10;
        start = 1'b0;

        wait(done);

        #100;

        $finish;
    end

endmodule