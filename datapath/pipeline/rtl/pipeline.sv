// 4 stage piepline

`timescale 1ns / 1ps

module pipeline #(
    parameter WIDTH = 8
) (
    input  logic             clk,
    input  logic             rst,
    input  logic             enable,

    input  logic [WIDTH-1:0] data_in,

    output logic [WIDTH-1:0] data_out
);

    logic [WIDTH-1:0] stage1;
    logic [WIDTH-1:0] stage2;
    logic [WIDTH-1:0] stage3;
    logic [WIDTH-1:0] stage4;


    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            stage1 <= '0;
            stage2 <= '0;
            stage3 <= '0;
            stage4 <= '0;

        end
        else if (enable) begin

            stage1 <= data_in;
            stage2 <= stage1;
            stage3 <= stage2;
            stage4 <= stage3;

        end

    end


    assign data_out = stage4;

endmodule