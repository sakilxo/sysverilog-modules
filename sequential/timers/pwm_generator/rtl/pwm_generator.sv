`timescale 1ns / 1ps

module pwm_generator #(

    parameter WIDTH = 8

)(

    input  logic             clk,
    input  logic             rst,
    input  logic [WIDTH-1:0] duty_cycle,

    output logic             pwm_out

);

    logic [WIDTH-1:0] counter;

    always_ff @(posedge clk or posedge rst) begin

        if (rst)

            counter <= '0;

        else

            counter <= counter + 1'b1;

    end

    always_comb begin

        if (counter < duty_cycle)
            pwm_out = 1'b1;
        else
            pwm_out = 1'b0;

    end

endmodule