// out = (~sel & a) | (sel & b)

`timescale 1ns / 1ps

module mux2x1 (
    input logic a,
    input logic b,
    input logic sel,

    output logic out
);

assign out = sel ? b : a;

endmodule