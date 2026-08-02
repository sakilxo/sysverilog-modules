`timescale 1ns / 1ps

module pulse_generator_tb;

    parameter PULSE_WIDTH = 5;

    logic clk;
    logic rst;
    logic trigger;
    logic pulse;

    pulse_generator #(

        .PULSE_WIDTH(PULSE_WIDTH)

    ) dut (

        .clk(clk),
        .rst(rst),
        .trigger(trigger),
        .pulse(pulse)

    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("pulse_generator.vcd");
        $dumpvars(0, pulse_generator_tb);

        clk = 0;
        rst = 1;
        trigger = 0;

        #10;
        rst = 0;

        // First trigger
        #15 trigger = 1;
        #10 trigger = 0;

        #80;

        // Second trigger
        #10 trigger = 1;
        #10 trigger = 0;

        #80;

        $finish;

    end

endmodule