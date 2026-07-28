`timescale 1ns / 1ps

module logical_right_shifter (

    input  logic [7:0] data,
    input  logic [2:0] shift,

    output logic [7:0] result

);

    assign result = data >> shift;

endmodule