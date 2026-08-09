`timescale 1ns / 1ps

module alu_8bit (

    input  logic [7:0] a,
    input  logic [7:0] b,

    input  logic [2:0] opcode,

    output logic [7:0] result,
    output logic       carry,
    output logic       zero,
    output logic       overflow

);

    logic [8:0] temp;

    always_comb begin

        result   = 8'b00000000;
        carry    = 1'b0;
        overflow = 1'b0;
        temp     = 9'b000000000;

        case (opcode)

            // ADD
            3'b000: begin

                temp   = {1'b0, a} + {1'b0, b};
                result = temp[7:0];
                carry  = temp[8];

                overflow =
                    (~(a[7] ^ b[7])) &
                    (result[7] ^ a[7]);

            end


            // SUBTRACT
            3'b001: begin

                temp   = {1'b0, a} - {1'b0, b};
                result = temp[7:0];

                carry = (a >= b);

                overflow =
                    (a[7] ^ b[7]) &
                    (result[7] ^ a[7]);

            end


            // AND
            3'b010: begin

                result = a & b;

            end


            // OR
            3'b011: begin

                result = a | b;

            end


            // XOR
            3'b100: begin

                result = a ^ b;

            end


            // NOT A
            3'b101: begin

                result = ~a;

            end


            // SHIFT LEFT
            3'b110: begin

                result = a << 1;
                carry  = a[7];

            end


            // SHIFT RIGHT
            3'b111: begin

                result = a >> 1;
                carry  = a[0];

            end


            default: begin

                result   = 8'b00000000;
                carry    = 1'b0;
                overflow = 1'b0;

            end

        endcase

        zero = (result == 8'b00000000);

    end

endmodule