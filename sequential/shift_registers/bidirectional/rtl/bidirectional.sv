// 0 -> shift left
// 1 -> shift right

`timescale 1ns / 1ps

module bidirectional (

    input  logic       clk,
    input  logic       rst,
    input  logic       dir,
    input  logic       serial_in,

    output logic [7:0] q

);

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            q <= 8'b0;

        else if (dir == 1'b0)
            q <= {q[6:0], serial_in};

        else
            q <= {serial_in, q[7:1]};

    end

endmodule