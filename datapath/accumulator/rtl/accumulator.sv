`timescale 1ns / 1ps

module accumulator #(
    parameter WIDTH = 8
) (
    input  logic             clk,
    input  logic             rst,
    input  logic             enable,
    input  logic [WIDTH-1:0] data_in,

    output logic [WIDTH-1:0] sum
);

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin
            sum <= '0;
        end
        else if (enable) begin
            sum <= sum + data_in;
        end

    end

endmodule