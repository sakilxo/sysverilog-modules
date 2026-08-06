// difference -> a xor b xor bin
// borrow     -> (not a and b) or (bin and not a) or (b and bin)

`timescale 1ns / 1ps

module full_subtractor (

    input  logic a,
    input  logic b,
    input  logic bin,

    output logic diff,
    output logic bout

);

    assign diff = a ^ b ^ bin;

    assign bout = (~a & b) |
                  (~a & bin) |
                  (b & bin);

endmodule