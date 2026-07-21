`timescale 1ns / 1ps

module demux1x4 (

    input logic in,
    input logic [1:0] sel,

    output logic y0,
    output logic y1,
    output logic y2,
    output logic y3

);

    always_comb begin

        y0 = 1'b0;
        y1 = 1'b0;
        y2 = 1'b0;
        y3 = 1'b0;

        case (sel)
            2'b00: y0 = in;
            2'b01: y1 = in;
            2'b10: y2 = in;
            2'b11: y3 = in;
        endcase

    end

endmodule