// 0 -> count up
// 1 -> count down

`timescale 1ns / 1ps

module up_down_counter (

    input  logic       clk,
    input  logic       rst,
    input  logic       dir,

    output logic [7:0] count

);

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            count <= 8'b0;

        else if (dir)
            count <= count - 1'b1;

        else
            count <= count + 1'b1;

    end

endmodule