// parameterized CRC-8 implementation
// polynomial: x^8 + x^2 + x + 1 --> 0x07

`timescale 1ns / 1ps

module crc #(
    parameter DATA_WIDTH = 8,
    parameter CRC_WIDTH  = 8,
    parameter POLYNOMIAL = 8'h07
) (
    input  logic                  clk,
    input  logic                  rst,
    input  logic                  enable,

    input  logic [DATA_WIDTH-1:0] data_in,

    output logic [CRC_WIDTH-1:0]  crc_out
);

    logic [CRC_WIDTH-1:0] crc_next;

    integer i;


    /*
     * CRC calculation
     */
    always_comb begin

        crc_next = crc_out;

        for (i = 0; i < DATA_WIDTH; i = i + 1) begin

            if (crc_next[CRC_WIDTH-1] ^
                data_in[DATA_WIDTH-1-i]) begin

                crc_next =
                    (crc_next << 1) ^ POLYNOMIAL;

            end
            else begin

                crc_next =
                    crc_next << 1;

            end

        end

    end


    /*
     * CRC register
     */
    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin
            crc_out <= '0;
        end
        else if (enable) begin
            crc_out <= crc_next;
        end

    end

endmodule