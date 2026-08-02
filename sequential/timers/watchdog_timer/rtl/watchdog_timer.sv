`timescale 1ns / 1ps

module watchdog_timer #(

    parameter WIDTH = 8,
    parameter TIMEOUT = 20

)(

    input  logic             clk,
    input  logic             rst,
    input  logic             feed,

    output logic             timeout,
    output logic [WIDTH-1:0] count

);

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            count   <= TIMEOUT;
            timeout <= 1'b0;

        end

        else begin

            timeout <= 1'b0;

            if (feed)

                count <= TIMEOUT;

            else if (count != 0)

                count <= count - 1'b1;

            else begin

                timeout <= 1'b1;
                count   <= TIMEOUT;

            end

        end

    end

endmodule