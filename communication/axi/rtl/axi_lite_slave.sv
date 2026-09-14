// Copyright (C) 2024, Advanced Micro Devices, Inc. All rights reserved.
// SPDX-License-Identifier: MIT

// 0x0 → Register 0
// 0x4 → Register 1
// 0x8 → Register 2
// 0xC → Register 3


`timescale 1ns / 1ps

module axi_lite_slave #(
    parameter integer ADDR_WIDTH = 4,
    parameter integer DATA_WIDTH = 32
) (
    input  logic                   clk,
    input  logic                   rst,

    // AXI4-Lite Write Address Channel
    input  logic [ADDR_WIDTH-1:0]  s_axi_awaddr,
    input  logic                   s_axi_awvalid,
    output logic                   s_axi_awready,

    // AXI4-Lite Write Data Channel
    input  logic [DATA_WIDTH-1:0]  s_axi_wdata,
    input  logic [DATA_WIDTH/8-1:0] s_axi_wstrb,
    input  logic                   s_axi_wvalid,
    output logic                   s_axi_wready,

    // AXI4-Lite Write Response Channel
    output logic [1:0]             s_axi_bresp,
    output logic                   s_axi_bvalid,
    input  logic                   s_axi_bready,

    // AXI4-Lite Read Address Channel
    input  logic [ADDR_WIDTH-1:0]  s_axi_araddr,
    input  logic                   s_axi_arvalid,
    output logic                   s_axi_arready,

    // AXI4-Lite Read Data Channel
    output logic [DATA_WIDTH-1:0]  s_axi_rdata,
    output logic [1:0]             s_axi_rresp,
    output logic                   s_axi_rvalid,
    input  logic                   s_axi_rready
);

    logic [DATA_WIDTH-1:0] registers [0:3];

    logic [ADDR_WIDTH-1:0] write_addr;
    logic                  aw_pending;

    integer i;

    always_comb begin
        s_axi_awready = !aw_pending && !s_axi_bvalid;
        s_axi_wready  = aw_pending && !s_axi_bvalid;
        s_axi_arready = !s_axi_rvalid;
    end

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 4; i = i + 1)
                registers[i] <= '0;

            write_addr <= '0;
            aw_pending <= 1'b0;

            s_axi_bvalid <= 1'b0;
            s_axi_bresp  <= 2'b00;

            s_axi_rvalid <= 1'b0;
            s_axi_rdata  <= '0;
            s_axi_rresp  <= 2'b00;
        end else begin

            // -------------------------
            // Write Address Channel
            // -------------------------
            if (s_axi_awvalid && s_axi_awready) begin
                write_addr <= s_axi_awaddr;
                aw_pending <= 1'b1;
            end

            // -------------------------
            // Write Data Channel
            // -------------------------
            if (s_axi_wvalid && s_axi_wready) begin

                if (write_addr[3:2] < 4) begin
                    for (i = 0; i < DATA_WIDTH/8; i = i + 1) begin
                        if (s_axi_wstrb[i])
                            registers[write_addr[3:2]][i*8 +: 8]
                                <= s_axi_wdata[i*8 +: 8];
                    end

                    s_axi_bresp <= 2'b00; // OKAY
                end else begin
                    s_axi_bresp <= 2'b10; // SLVERR
                end

                s_axi_bvalid <= 1'b1;
                aw_pending   <= 1'b0;
            end

            // -------------------------
            // Write Response Channel
            // -------------------------
            if (s_axi_bvalid && s_axi_bready)
                s_axi_bvalid <= 1'b0;

            // -------------------------
            // Read Address Channel
            // -------------------------
            if (s_axi_arvalid && s_axi_arready) begin

                if (s_axi_araddr[3:2] < 4) begin
                    s_axi_rdata <= registers[s_axi_araddr[3:2]];
                    s_axi_rresp <= 2'b00; // OKAY
                end else begin
                    s_axi_rdata <= '0;
                    s_axi_rresp <= 2'b10; // SLVERR
                end

                s_axi_rvalid <= 1'b1;
            end

            // -------------------------
            // Read Data Channel
            // -------------------------
            if (s_axi_rvalid && s_axi_rready)
                s_axi_rvalid <= 1'b0;

        end
    end

endmodule