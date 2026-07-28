`timescale 1ns /1ps

module logic_gates_tb;

    logic a;
    logic b;

    logic and_out;
    logic or_out;
    logic xor_out;
    logic xnor_out;
    logic nand_out;
    logic nor_out;
    logic not_a_out;
    logic not_b_out;

    logic_gates dut (
        .a(a),
        .b(b),
        .and_out(and_out),
        .or_out(or_out),
        .xor_out(xor_out),
        .xnor_out(xnor_out),
        .nand_out(nand_out),
        .nor_out(nor_out),
        .not_a_out(not_a_out),
        .not_b_out(not_b_out)
    );

    initial begin

        $dumpfile("logic_gates.vcd");
        $dumpvars(0, logic_gates_tb);

        $display("A B | AND OR XOR XNOR NAND NOR NOTA NOTB");
        $display("-----------------------------------------");

        a = 0; b = 0; #10;
        $display("%b %b |  %b   %b   %b    %b     %b    %b    %b    %b",
                 a,b,and_out,or_out,xor_out,xnor_out,nand_out,nor_out,not_a_out,not_b_out);

        a = 0; b = 1; #10;
        $display("%b %b |  %b   %b   %b    %b     %b    %b    %b    %b",
                 a,b,and_out,or_out,xor_out,xnor_out,nand_out,nor_out,not_a_out,not_b_out);

        a = 1; b = 0; #10;
        $display("%b %b |  %b   %b   %b    %b     %b    %b    %b    %b",
                 a,b,and_out,or_out,xor_out,xnor_out,nand_out,nor_out,not_a_out,not_b_out);

        a = 1; b = 1; #10;
        $display("%b %b |  %b   %b   %b    %b     %b    %b    %b    %b",
                 a,b,and_out,or_out,xor_out,xnor_out,nand_out,nor_out,not_a_out,not_b_out);

        $finish;

    end

endmodule