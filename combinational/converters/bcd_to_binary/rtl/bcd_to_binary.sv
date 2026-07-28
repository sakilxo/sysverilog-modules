`timescale 1ns / 1ps

module bcd_to_binary (

    input  logic [3:0] bcd,

    output logic [3:0] binary

);

    always_comb begin

        if (bcd <= 4'd9)
            binary = bcd;
        else
            binary = 4'd0;

    end

endmodule