`timescale 1ns / 1ps

module binary_to_excess3 (

    input  logic [3:0] binary,

    output logic [3:0] excess3

);

    assign excess3 = binary + 4'd3;

endmodule