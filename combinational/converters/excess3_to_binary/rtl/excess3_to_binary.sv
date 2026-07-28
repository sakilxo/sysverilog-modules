`timescale 1ns / 1ps

module excess3_to_binary (

    input  logic [3:0] excess3,

    output logic [3:0] binary

);

    always_comb begin

        if (excess3 >= 4'd3 && excess3 <= 4'd12)
            binary = excess3 - 4'd3;
        else
            binary = 4'd0;

    end

endmodule