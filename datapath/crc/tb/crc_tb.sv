`timescale 1ns / 1ps

module crc_tb;

    logic       clk;
    logic       rst;
    logic       enable;

    logic [7:0] data_in;
    logic [7:0] crc_out;


    crc dut (

        .clk(clk),
        .rst(rst),
        .enable(enable),

        .data_in(data_in),

        .crc_out(crc_out)

    );


    always #5 clk = ~clk;


    task send_byte(input logic [7:0] data);

        begin

            @(negedge clk);

            data_in = data;
            enable  = 1'b1;

            @(posedge clk);

            #1;

            $display(
                "data = %02h | CRC = %02h",
                data_in,
                crc_out
            );

        end

    endtask


    initial begin

        $dumpfile("crc.vcd");
        $dumpvars(0, crc_tb);


        clk    = 1'b0;
        rst    = 1'b1;
        enable = 1'b0;
        data_in = 8'h00;


        #12;

        rst = 1'b0;


        // Process bytes
        send_byte(8'h31);
        send_byte(8'h32);
        send_byte(8'h33);
        send_byte(8'h34);
        send_byte(8'h35);


        // Hold CRC
        @(negedge clk);

        enable  = 1'b0;
        data_in = 8'hFF;

        #20;


        $finish;

    end

endmodule