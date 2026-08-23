`timescale 1ns / 1ps

module sequence_detector_tb;

    logic clk;
    logic rst;
    logic in;

    logic detected;


    sequence_detector dut (
        .clk(clk),
        .rst(rst),
        .in(in),
        .detected(detected)
    );


    always #5 clk = ~clk;


    task send_bit(input logic input_bit);

        begin

            @(negedge clk);

            in = input_bit;

            @(posedge clk);

            #1;

            $display(
                "time=%0t input=%b state=%s detected=%b",
                $time,
                in,
                dut.state.name(),
                detected
            );

        end

    endtask


    initial begin

        $dumpfile("sequence_detector.vcd");
        $dumpvars(0, sequence_detector_tb);


        clk = 1'b0;
        rst = 1'b1;
        in  = 1'b0;


        #12;

        rst = 1'b0;


        // Detect 1011
        send_bit(1);
        send_bit(0);
        send_bit(1);
        send_bit(1);


        // Extra sequence
        send_bit(0);
        send_bit(1);
        send_bit(0);
        send_bit(1);
        send_bit(1);


        #20;

        $finish;

    end

endmodule