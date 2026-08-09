`timescale 1ns / 1ps

module alu_8bit_tb;

    logic [7:0] a;
    logic [7:0] b;

    logic [2:0] opcode;

    logic [7:0] result;
    logic       carry;
    logic       zero;
    logic       overflow;


    alu_8bit dut (

        .a(a),
        .b(b),
        .opcode(opcode),

        .result(result),
        .carry(carry),
        .zero(zero),
        .overflow(overflow)

    );


    initial begin

        $dumpfile("alu_8bit.vcd");
        $dumpvars(0, alu_8bit_tb);


        // ADD: 20 + 10 = 30
        a = 8'd20;
        b = 8'd10;
        opcode = 3'b000;
        #10;


        // SUBTRACT: 20 - 10 = 10
        a = 8'd20;
        b = 8'd10;
        opcode = 3'b001;
        #10;


        // AND
        a = 8'b11001100;
        b = 8'b10101010;
        opcode = 3'b010;
        #10;


        // OR
        a = 8'b11001100;
        b = 8'b10101010;
        opcode = 3'b011;
        #10;


        // XOR
        a = 8'b11001100;
        b = 8'b10101010;
        opcode = 3'b100;
        #10;


        // NOT A
        a = 8'b10101010;
        b = 8'b00000000;
        opcode = 3'b101;
        #10;


        // SHIFT LEFT
        a = 8'b10101010;
        b = 8'b00000000;
        opcode = 3'b110;
        #10;


        // SHIFT RIGHT
        a = 8'b10101010;
        b = 8'b00000000;
        opcode = 3'b111;
        #10;


        // ADD with carry
        a = 8'hFF;
        b = 8'h01;
        opcode = 3'b000;
        #10;


        // Zero result
        a = 8'h55;
        b = 8'h55;
        opcode = 3'b001;
        #10;


        $finish;

    end

endmodule