`timescale 1ns / 1ps

module alu_4bit_tb;

    logic [3:0] a;
    logic [3:0] b;

    logic [2:0] opcode;

    logic [3:0] result;
    logic       carry;
    logic       zero;
    logic       overflow;


    alu_4bit dut (

        .a(a),
        .b(b),
        .opcode(opcode),

        .result(result),
        .carry(carry),
        .zero(zero),
        .overflow(overflow)

    );


    initial begin

        $dumpfile("alu_4bit.vcd");
        $dumpvars(0, alu_4bit_tb);


        // ADD: 5 + 3 = 8
        a = 4'd5;
        b = 4'd3;
        opcode = 3'b000;
        #10;


        // SUB: 5 - 3 = 2
        a = 4'd5;
        b = 4'd3;
        opcode = 3'b001;
        #10;


        // AND
        a = 4'b1100;
        b = 4'b1010;
        opcode = 3'b010;
        #10;


        // OR
        a = 4'b1100;
        b = 4'b1010;
        opcode = 3'b011;
        #10;


        // XOR
        a = 4'b1100;
        b = 4'b1010;
        opcode = 3'b100;
        #10;


        // NOT A
        a = 4'b1010;
        b = 4'b0000;
        opcode = 3'b101;
        #10;


        // SHIFT LEFT
        a = 4'b1010;
        b = 4'b0000;
        opcode = 3'b110;
        #10;


        // SHIFT RIGHT
        a = 4'b1010;
        b = 4'b0000;
        opcode = 3'b111;
        #10;


        // ADD with carry
        a = 4'b1111;
        b = 4'b0001;
        opcode = 3'b000;
        #10;


        // Zero result
        a = 4'b0101;
        b = 4'b0101;
        opcode = 3'b001;
        #10;


        $finish;

    end

endmodule