// sel 00 -> hold
// sel 01 -> shift right
// sel 10 -> shift left
// sel 11 -> parallel load

`timescale 1ns / 1ps

module universal (

    input  logic       clk,
    input  logic       rst,
    input  logic [1:0] sel,
    input  logic       serial_left,
    input  logic       serial_right,
    input  logic [7:0] parallel_in,

    output logic [7:0] q

);

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            q <= 8'b0;

        else begin

            case (sel)

                2'b00: q <= q;

                2'b01: q <= {serial_right, q[7:1]};

                2'b10: q <= {q[6:0], serial_left};

                2'b11: q <= parallel_in;

            endcase

        end

    end

endmodule