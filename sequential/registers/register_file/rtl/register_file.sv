`timescale 1ns / 1ps

module register_file (

    input  logic clk,
    input  logic rst,
    input  logic we,
    input  logic [2:0] waddr,
    input  logic [2:0] raddr,
    input  logic [7:0] wdata,

    output logic [7:0] rdata

);

    logic [7:0] mem [0:7];

    integer i;

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            for (i = 0; i < 8; i = i + 1)
                mem[i] <= 8'b0;

        end

        else if (we)

            mem[waddr] <= wdata;

    end

    assign rdata = mem[raddr];

endmodule