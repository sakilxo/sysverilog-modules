`timescale 1ns/1ps

module mux2x1_tb;

    logic a;
    logic b;
    logic sel;

    logic out;

    mux2x1 dut (
        .a(a),
        .b(b),
        .sel(sel),
        .out(out)
    );

    initial begin

        $dumpfile("mux2x1.vcd");
        $dumpvars(0, mux2x1_tb);

        $display("SEL A B | OUT");
        $display("-------------");

        for (int i = 0; i < 8; i++) begin
            {sel, a, b} = i[2:0];
            #10;

            $display("%b   %b %b |  %b",
                sel, a, b, out);
        end

        $finish;
    end

endmodule