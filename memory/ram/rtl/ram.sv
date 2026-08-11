`timescale 1ns / 1ps

module ram #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4
) (
    input  logic                  clk,
    input  logic                  we,

    input  logic [ADDR_WIDTH-1:0] addr,
    input  logic [DATA_WIDTH-1:0] write_data,

    output logic [DATA_WIDTH-1:0] read_data
);

    localparam DEPTH = 1 << ADDR_WIDTH;

    logic [DATA_WIDTH-1:0] memory [0:DEPTH-1];


    always_ff @(posedge clk) begin  // sync write

        if (we) begin
            memory[addr] <= write_data;
        end

    end

    assign read_data = memory[addr];  // async read

endmodule