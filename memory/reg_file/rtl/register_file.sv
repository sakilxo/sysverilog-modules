`timescale 1ns / 1ps

module register_file #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 5
) (
    input  logic                  clk,
    input  logic                  rst,

    // Read ports
    input  logic [ADDR_WIDTH-1:0] read_addr1,
    input  logic [ADDR_WIDTH-1:0] read_addr2,

    output logic [DATA_WIDTH-1:0] read_data1,
    output logic [DATA_WIDTH-1:0] read_data2,

    // Write port
    input  logic [ADDR_WIDTH-1:0] write_addr,
    input  logic [DATA_WIDTH-1:0] write_data,
    input  logic                  write_enable
);

    localparam DEPTH = 1 << ADDR_WIDTH;

    logic [DATA_WIDTH-1:0] registers [0:DEPTH-1];


    /*
     * Reset registers
     */
    integer i;

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            for (i = 0; i < DEPTH; i = i + 1) begin
                registers[i] <= '0;
            end

        end

        else begin

            if (write_enable) begin
                registers[write_addr] <= write_data;
            end

        end

    end


    /*
     * Asynchronous read ports
     */
    assign read_data1 = registers[read_addr1];
    assign read_data2 = registers[read_addr2];

endmodule