`timescale 1ns / 1ps

module fifo #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH      = 16
) (
    input  logic                  clk,
    input  logic                  rst,

    input  logic                  wr_en,
    input  logic                  rd_en,

    input  logic [DATA_WIDTH-1:0] write_data,
    output logic [DATA_WIDTH-1:0] read_data,

    output logic                  full,
    output logic                  empty
);

    localparam ADDR_WIDTH = $clog2(DEPTH);

    logic [DATA_WIDTH-1:0] memory [0:DEPTH-1];

    logic [ADDR_WIDTH-1:0] write_ptr;
    logic [ADDR_WIDTH-1:0] read_ptr;

    logic [ADDR_WIDTH:0] count;


    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            write_ptr <= '0;
            read_ptr  <= '0;
            count     <= '0;

            read_data <= '0;

        end
        else begin

            /*
             * Write
             */
            if (wr_en && !full) begin

                memory[write_ptr] <= write_data;

                if (write_ptr == ADDR_WIDTH'(DEPTH-1)) begin
                    write_ptr <= '0;
                end
                else begin
                    write_ptr <= write_ptr + 1'b1;
                end

            end


            /*
             * Read
             */
            if (rd_en && !empty) begin

                read_data <= memory[read_ptr];

                if (read_ptr == ADDR_WIDTH'(DEPTH-1)) begin
                    read_ptr <= '0;
                end
                else begin
                    read_ptr <= read_ptr + 1'b1;
                end

            end


            /*
             * Update count
             */
            case ({wr_en && !full, rd_en && !empty})

                2'b10:
                    count <= count + 1'b1;

                2'b01:
                    count <= count - 1'b1;

                default:
                    count <= count;

            endcase

        end

    end


    assign full  = (count == DEPTH);
    assign empty = (count == 0);

endmodule