`timescale 1ns / 1ps

module binary_to_onehot (

    input  logic [3:0] binary,

    output logic [15:0] onehot

);

    always_comb begin

        onehot = 16'b0;
        onehot[binary] = 1'b1;

    end

endmodule