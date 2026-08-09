// difference -> a xor b
// borrow     -> not a and b

`timescale 1ns / 1ps

module half_subtractor (

    input  logic a,
    input  logic b,

    output logic diff,
    output logic borrow

);

    assign diff   = a ^ b;
    assign borrow = ~a & b;

endmodule