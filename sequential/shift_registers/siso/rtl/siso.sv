`timescale 1ns / 1ps

module siso (

    input  logic clk,
    input  logic rst,
    input  logic serial_in,

    output logic serial_out

);

    logic [7:0] shift_reg;

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            shift_reg <= 8'b0;
        else
            shift_reg <= {shift_reg[6:0], serial_in};

    end

    assign serial_out = shift_reg[7];

endmodule