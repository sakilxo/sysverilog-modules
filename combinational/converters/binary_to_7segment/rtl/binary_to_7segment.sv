`timescale 1ns / 1ps

module binary_to_seven_segment (

    input  logic [3:0] binary,

    output logic [6:0] segments

);

    always_comb begin

        case (binary)

            4'd0: segments = 7'b1111110;
            4'd1: segments = 7'b0110000;
            4'd2: segments = 7'b1101101;
            4'd3: segments = 7'b1111001;
            4'd4: segments = 7'b0110011;
            4'd5: segments = 7'b1011011;
            4'd6: segments = 7'b1011111;
            4'd7: segments = 7'b1110000;
            4'd8: segments = 7'b1111111;
            4'd9: segments = 7'b1111011;
            4'd10: segments = 7'b1110111; // A
            4'd11: segments = 7'b0011111; // b
            4'd12: segments = 7'b1001110; // C
            4'd13: segments = 7'b0111101; // d
            4'd14: segments = 7'b1001111; // E
            4'd15: segments = 7'b1000111; // F

            default: segments = 7'b0000000;

        endcase

    end

endmodule