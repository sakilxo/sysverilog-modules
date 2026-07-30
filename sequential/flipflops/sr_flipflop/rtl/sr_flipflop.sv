`timescale 1ns / 1ps

module sr_flipflop (

    input  logic clk,
    input  logic rst,
    input  logic s,
    input  logic r,

    output logic q

);

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            q <= 1'b0;
        else begin

            case ({s, r})

                2'b00: q <= q;
                2'b01: q <= 1'b0;
                2'b10: q <= 1'b1;
                2'b11: q <= 1'bx;

            endcase

        end

    end

endmodule