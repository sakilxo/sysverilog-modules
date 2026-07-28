`timescale 1ns / 1ps

module parameterized_parity_generator #(

    parameter N = 8

)(

    input  logic [N-1:0] data,

    output logic even_parity,
    output logic odd_parity

);

    assign even_parity = ^data;
    assign odd_parity  = ~(^data);

endmodule