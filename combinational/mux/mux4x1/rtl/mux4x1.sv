`timescale 1ns / 1ps

module mux4x1 (
    input logic d0,
    input logic d1,
    input logic d2,
    input logic d3,

    input logic [1:0] sel,

    output logic out
);

    always_comb begin
        case (sel)
            2'b00: out = d0;
            2'b01: out = d1;
            2'b10: out = d2;
            2'b11: out = d3;
            default: out = 1'b0;
        endcase
    end

endmodule