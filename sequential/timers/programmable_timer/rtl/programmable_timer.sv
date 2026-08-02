`timescale 1ns / 1ps

module programmable_timer #(

    parameter WIDTH = 8

)(

    input  logic             clk,
    input  logic             rst,
    input  logic             start,
    input  logic [WIDTH-1:0] load_value,

    output logic             timeout,
    output logic [WIDTH-1:0] count

);

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            count   <= '0;
            timeout <= 1'b0;

        end

        else begin

            timeout <= 1'b0;

            if (start)

                count <= load_value;

            else if (count != 0) begin

                count <= count - 1'b1;

                if (count == 1)
                    timeout <= 1'b1;

            end

        end

    end

endmodule