`timescale 1ns / 1ps

module rom #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4
) (
    input  logic [ADDR_WIDTH-1:0] addr,
    output logic [DATA_WIDTH-1:0] data
);

    logic [DATA_WIDTH-1:0] memory [0:(1 << ADDR_WIDTH)-1];

    initial begin

        memory[0]  = 8'h10;
        memory[1]  = 8'h20;
        memory[2]  = 8'h30;
        memory[3]  = 8'h40;
        memory[4]  = 8'h50;
        memory[5]  = 8'h60;
        memory[6]  = 8'h70;
        memory[7]  = 8'h80;
        memory[8]  = 8'h90;
        memory[9]  = 8'hA0;
        memory[10] = 8'hB0;
        memory[11] = 8'hC0;
        memory[12] = 8'hD0;
        memory[13] = 8'hE0;
        memory[14] = 8'hF0;
        memory[15] = 8'hFF;

    end

    assign data = memory[addr];

endmodule