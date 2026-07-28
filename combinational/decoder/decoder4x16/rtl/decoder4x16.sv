`timescale 1ns / 1ps

module decoder4x16 (

    input  logic [3:0] in,

    output logic y0,
    output logic y1,
    output logic y2,
    output logic y3,
    output logic y4,
    output logic y5,
    output logic y6,
    output logic y7,
    output logic y8,
    output logic y9,
    output logic y10,
    output logic y11,
    output logic y12,
    output logic y13,
    output logic y14,
    output logic y15

);

    always_comb begin

        y0  = 1'b0;
        y1  = 1'b0;
        y2  = 1'b0;
        y3  = 1'b0;
        y4  = 1'b0;
        y5  = 1'b0;
        y6  = 1'b0;
        y7  = 1'b0;
        y8  = 1'b0;
        y9  = 1'b0;
        y10 = 1'b0;
        y11 = 1'b0;
        y12 = 1'b0;
        y13 = 1'b0;
        y14 = 1'b0;
        y15 = 1'b0;

        case (in)
            4'b0000: y0  = 1'b1;
            4'b0001: y1  = 1'b1;
            4'b0010: y2  = 1'b1;
            4'b0011: y3  = 1'b1;
            4'b0100: y4  = 1'b1;
            4'b0101: y5  = 1'b1;
            4'b0110: y6  = 1'b1;
            4'b0111: y7  = 1'b1;
            4'b1000: y8  = 1'b1;
            4'b1001: y9  = 1'b1;
            4'b1010: y10 = 1'b1;
            4'b1011: y11 = 1'b1;
            4'b1100: y12 = 1'b1;
            4'b1101: y13 = 1'b1;
            4'b1110: y14 = 1'b1;
            4'b1111: y15 = 1'b1;
            default: begin
                y0  = 1'b0;
                y1  = 1'b0;
                y2  = 1'b0;
                y3  = 1'b0;
                y4  = 1'b0;
                y5  = 1'b0;
                y6  = 1'b0;
                y7  = 1'b0;
                y8  = 1'b0;
                y9  = 1'b0;
                y10 = 1'b0;
                y11 = 1'b0;
                y12 = 1'b0;
                y13 = 1'b0;
                y14 = 1'b0;
                y15 = 1'b0;
            end
        endcase

    end

endmodule