`timescale 1ns / 1ps

module pulse_generator #(

    parameter PULSE_WIDTH = 5

)(

    input  logic clk,
    input  logic rst,
    input  logic trigger,

    output logic pulse

);

    localparam WIDTH = $clog2(PULSE_WIDTH + 1);

    logic [WIDTH-1:0] counter;
    logic trigger_d;

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            trigger_d <= 1'b0;
            counter   <= '0;
            pulse     <= 1'b0;

        end

        else begin

            trigger_d <= trigger;

            if (trigger && !trigger_d) begin

                pulse   <= 1'b1;
                counter <= PULSE_WIDTH - 1;

            end

            else if (counter != 0) begin

                counter <= counter - 1'b1;
                pulse   <= 1'b1;

            end

            else begin

                pulse <= 1'b0;

            end

        end

    end

endmodule