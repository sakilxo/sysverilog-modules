`timescale 1ns / 1ps

module even_parity_checker (

    input  logic [3:0] data,
    input  logic parity,

    output logic error

);

    assign error = ^{data, parity};

endmodule