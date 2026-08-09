`timescale 1ns / 1ps

module alu_4bit (

    input  logic [3:0] a,
    input  logic [3:0] b,

    input  logic [2:0] opcode,

    output logic [3:0] result,
    output logic       carry,
    output logic       zero,
    output logic       overflow

);

    logic [4:0] temp;

    always_comb begin

        result   = 4'b0000;
        carry    = 1'b0;
        overflow = 1'b0;
        temp     = 5'b00000;

        case (opcode)

            // ADD
            3'b000: begin

                temp   = {1'b0, a} + {1'b0, b};
                result = temp[3:0];
                carry  = temp[4];

                overflow =
                    (~(a[3] ^ b[3])) &
                    (result[3] ^ a[3]);

            end


            // SUBTRACT
            3'b001: begin

                temp   = {1'b0, a} - {1'b0, b};
                result = temp[3:0];

                carry = (a >= b);

                overflow =
                    (a[3] ^ b[3]) &
                    (result[3] ^ a[3]);

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
                carry  = a[3];

            end


            // SHIFT RIGHT
            3'b111: begin

                result = a >> 1;
                carry  = a[0];

            end

            default: begin

                result   = 4'b0000;
                carry    = 1'b0;
                overflow = 1'b0;

            end

        endcase

        zero = (result == 4'b0000);

    end

endmodule