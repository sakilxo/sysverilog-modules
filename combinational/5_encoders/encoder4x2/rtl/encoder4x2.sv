`timescale 1ns / 1ps

module encoder4x2 (
    input  logic [3:0] in,
    output logic [1:0] out
);

    always_comb begin
        case (in)
            4'b0001: out = 2'b00;
            4'b0010: out = 2'b01;
            4'b0100: out = 2'b10;
            4'b1000: out = 2'b11;
            default: out = 2'b00;   // Invalid input
        endcase
    end

endmodule