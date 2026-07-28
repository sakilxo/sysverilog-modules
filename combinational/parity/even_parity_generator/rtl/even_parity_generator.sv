`timescale 1ns / 1ps

module even_parity_generator (

    input  logic [3:0] data,
    output logic parity

);

    assign parity = ^data;

endmodule