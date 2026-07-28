`timescale 1ns / 1ps

module onehot_to_binary (

    input  logic [15:0] onehot,

    output logic [3:0] binary,
    output logic        valid

);

    always_comb begin

        binary = 4'd0;
        valid  = 1'b0;

        case (onehot)
            16'b0000000000000001: begin binary = 4'd0;  valid = 1'b1; end
            16'b0000000000000010: begin binary = 4'd1;  valid = 1'b1; end
            16'b0000000000000100: begin binary = 4'd2;  valid = 1'b1; end
            16'b0000000000001000: begin binary = 4'd3;  valid = 1'b1; end
            16'b0000000000010000: begin binary = 4'd4;  valid = 1'b1; end
            16'b0000000000100000: begin binary = 4'd5;  valid = 1'b1; end
            16'b0000000001000000: begin binary = 4'd6;  valid = 1'b1; end
            16'b0000000010000000: begin binary = 4'd7;  valid = 1'b1; end
            16'b0000000100000000: begin binary = 4'd8;  valid = 1'b1; end
            16'b0000001000000000: begin binary = 4'd9;  valid = 1'b1; end
            16'b0000010000000000: begin binary = 4'd10; valid = 1'b1; end
            16'b0000100000000000: begin binary = 4'd11; valid = 1'b1; end
            16'b0001000000000000: begin binary = 4'd12; valid = 1'b1; end
            16'b0010000000000000: begin binary = 4'd13; valid = 1'b1; end
            16'b0100000000000000: begin binary = 4'd14; valid = 1'b1; end
            16'b1000000000000000: begin binary = 4'd15; valid = 1'b1; end
            default: begin
                binary = 4'd0;
                valid  = 1'b0;
            end
        endcase

    end

endmodule