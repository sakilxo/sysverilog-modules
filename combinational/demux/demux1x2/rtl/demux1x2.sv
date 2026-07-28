`timescale 1ns / 1ps

module demux1x2 (

    input logic in,
    input logic sel,

    output logic y0,
    output logic y1

);

    always_comb begin

        y0 = 1'b0;
        y1 = 1'b0;

        case (sel)
            1'b0: y0 = in;
            1'b1: y1 = in;
        endcase

    end

endmodule