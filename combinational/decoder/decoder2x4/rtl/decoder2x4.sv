`timescale 1ns / 1ps

module decoder2x4 (

    input  logic [1:0] in,

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

        case (in)
            2'b00: y0 = 1'b1;
            2'b01: y1 = 1'b1;
            2'b10: y2 = 1'b1;
            2'b11: y3 = 1'b1;
            default: begin
                y0 = 1'b0;
                y1 = 1'b0;
                y2 = 1'b0;
                y3 = 1'b0;
            end
        endcase

    end

endmodule