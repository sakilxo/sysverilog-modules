// 1 -> load parallel data
// 0 -> shift data out serially

`timescale 1ns / 1ps

module piso (

    input  logic       clk,
    input  logic       rst,
    input  logic       load,
    input  logic [7:0] parallel_in,

    output logic       serial_out

);

    logic [7:0] shift_reg;

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            shift_reg <= 8'b0;

        else if (load)
            shift_reg <= parallel_in;

        else
            shift_reg <= {shift_reg[6:0], 1'b0};

    end

    assign serial_out = shift_reg[7];

endmodule