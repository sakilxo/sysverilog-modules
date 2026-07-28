`timescale 1ns / 1ps

module barrel_shifter (

    input  logic [7:0] data,
    input  logic [2:0] shift,
    input  logic       dir,

    output logic [7:0] result

);

    always_comb begin

        case (dir)

            1'b0: result = data << shift;
            1'b1: result = data >> shift;

        endcase

    end

endmodule