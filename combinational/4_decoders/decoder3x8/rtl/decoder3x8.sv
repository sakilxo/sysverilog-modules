`timescale 1ns / 1ps

module decoder3x8 (

    input  logic [2:0] in,

    output logic y0,
    output logic y1,
    output logic y2,
    output logic y3,
    output logic y4,
    output logic y5,
    output logic y6,
    output logic y7

);

    always_comb begin

        y0 = 1'b0;
        y1 = 1'b0;
        y2 = 1'b0;
        y3 = 1'b0;
        y4 = 1'b0;
        y5 = 1'b0;
        y6 = 1'b0;
        y7 = 1'b0;

        case (in)
            3'b000: y0 = 1'b1;
            3'b001: y1 = 1'b1;
            3'b010: y2 = 1'b1;
            3'b011: y3 = 1'b1;
            3'b100: y4 = 1'b1;
            3'b101: y5 = 1'b1;
            3'b110: y6 = 1'b1;
            3'b111: y7 = 1'b1;
            default: begin
                y0 = 1'b0;
                y1 = 1'b0;
                y2 = 1'b0;
                y3 = 1'b0;
                y4 = 1'b0;
                y5 = 1'b0;
                y6 = 1'b0;
                y7 = 1'b0;
            end
        endcase

    end

endmodule