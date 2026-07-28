`timescale 1ns / 1ps

module mux8x1 (
    input logic d0,
    input logic d1,
    input logic d2,
    input logic d3,
    input logic d4,
    input logic d5,
    input logic d6,
    input logic d7,

    input logic [2:0] sel,

    output logic out
);

    always_comb begin
        case (sel)
            3'b000: out = d0;
            3'b001: out = d1;
            3'b010: out = d2;
            3'b011: out = d3;
            3'b100: out = d4;
            3'b101: out = d5;
            3'b110: out = d6;
            3'b111: out = d7;
            default: out = 1'b0;
        endcase
    end

endmodule