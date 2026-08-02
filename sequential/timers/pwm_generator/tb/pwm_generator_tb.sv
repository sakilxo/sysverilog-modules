`timescale 1ns / 1ps

module pwm_generator_tb;

    parameter WIDTH = 8;

    logic             clk;
    logic             rst;
    logic [WIDTH-1:0] duty_cycle;
    logic             pwm_out;

    pwm_generator #(

        .WIDTH(WIDTH)

    ) dut (

        .clk(clk),
        .rst(rst),
        .duty_cycle(duty_cycle),
        .pwm_out(pwm_out)

    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("pwm_generator.vcd");
        $dumpvars(0, pwm_generator_tb);

        clk = 0;
        rst = 1;
        duty_cycle = 0;

        #10;
        rst = 0;

        // 25% duty cycle
        duty_cycle = 8'd64;
        repeat (300)
            #10;

        // 50% duty cycle
        duty_cycle = 8'd128;
        repeat (300)
            #10;

        // 75% duty cycle
        duty_cycle = 8'd192;
        repeat (300)
            #10;

        // 100% duty cycle
        duty_cycle = 8'd255;
        repeat (300)
            #10;

        $finish;

    end

endmodule