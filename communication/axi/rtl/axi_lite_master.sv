    //          AXI4-Lite
    //             │
    //    ┌────────┴────────┐
    //    │                 │
    // MASTER             SLAVE
    //    │                 │
    //    │── AWADDR ──────>│
    //    │── WDATA ───────>│
    //    │<── BRESP ───────│
    //    │                 │
    //    │── ARADDR ──────>│
    //    │<── RDATA ───────│
    //    │<── RRESP ───────│


`timescale 1ns / 1ps

module axi_lite_master #(
    parameter integer ADDR_WIDTH = 4,
    parameter integer DATA_WIDTH = 32
) (
    input  logic                    clk,
    input  logic                    rst,

    // Control interface
    input  logic                    write_start,
    input  logic                    read_start,

    input  logic [ADDR_WIDTH-1:0]   write_addr,
    input  logic [DATA_WIDTH-1:0]   write_data,
    input  logic [DATA_WIDTH/8-1:0] write_strb,

    input  logic [ADDR_WIDTH-1:0]   read_addr,

    output logic [DATA_WIDTH-1:0]   read_data,
    output logic                    write_done,
    output logic                    read_done,
    output logic                    error,

    // AXI4-Lite Write Address Channel
    output logic [ADDR_WIDTH-1:0]   m_axi_awaddr,
    output logic                    m_axi_awvalid,
    input  logic                    m_axi_awready,

    // AXI4-Lite Write Data Channel
    output logic [DATA_WIDTH-1:0]   m_axi_wdata,
    output logic [DATA_WIDTH/8-1:0] m_axi_wstrb,
    output logic                    m_axi_wvalid,
    input  logic                    m_axi_wready,

    // AXI4-Lite Write Response Channel
    input  logic [1:0]              m_axi_bresp,
    input  logic                    m_axi_bvalid,
    output logic                    m_axi_bready,

    // AXI4-Lite Read Address Channel
    output logic [ADDR_WIDTH-1:0]   m_axi_araddr,
    output logic                    m_axi_arvalid,
    input  logic                    m_axi_arready,

    // AXI4-Lite Read Data Channel
    input  logic [DATA_WIDTH-1:0]   m_axi_rdata,
    input  logic [1:0]              m_axi_rresp,
    input  logic                    m_axi_rvalid,
    output logic                    m_axi_rready
);

    typedef enum logic [2:0] {
        IDLE,
        WRITE,
        WRITE_RESP,
        READ,
        READ_DATA
    } state_t;

    state_t state;

    logic aw_done;
    logic w_done;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;

            m_axi_awaddr  <= '0;
            m_axi_awvalid <= 1'b0;

            m_axi_wdata   <= '0;
            m_axi_wstrb   <= '0;
            m_axi_wvalid  <= 1'b0;

            m_axi_bready  <= 1'b0;

            m_axi_araddr  <= '0;
            m_axi_arvalid <= 1'b0;

            m_axi_rready  <= 1'b0;

            read_data  <= '0;
            write_done <= 1'b0;
            read_done  <= 1'b0;
            error      <= 1'b0;

            aw_done <= 1'b0;
            w_done  <= 1'b0;
        end else begin

            write_done <= 1'b0;
            read_done  <= 1'b0;

            case (state)

                IDLE: begin
                    m_axi_awvalid <= 1'b0;
                    m_axi_wvalid  <= 1'b0;
                    m_axi_bready  <= 1'b0;
                    m_axi_arvalid <= 1'b0;
                    m_axi_rready  <= 1'b0;

                    aw_done <= 1'b0;
                    w_done  <= 1'b0;

                    if (write_start) begin
                        m_axi_awaddr  <= write_addr;
                        m_axi_awvalid <= 1'b1;

                        m_axi_wdata   <= write_data;
                        m_axi_wstrb   <= write_strb;
                        m_axi_wvalid  <= 1'b1;

                        state <= WRITE;
                    end else if (read_start) begin
                        m_axi_araddr  <= read_addr;
                        m_axi_arvalid <= 1'b1;

                        state <= READ;
                    end
                end

                WRITE: begin

                    // Address handshake
                    if (m_axi_awvalid && m_axi_awready) begin
                        m_axi_awvalid <= 1'b0;
                        aw_done <= 1'b1;
                    end

                    // Data handshake
                    if (m_axi_wvalid && m_axi_wready) begin
                        m_axi_wvalid <= 1'b0;
                        w_done <= 1'b1;
                    end

                    // Both address and data accepted
                    if ((aw_done || (m_axi_awvalid && m_axi_awready)) &&
                        (w_done  || (m_axi_wvalid  && m_axi_wready))) begin

                        m_axi_bready <= 1'b1;
                        state <= WRITE_RESP;
                    end
                end

                WRITE_RESP: begin

                    if (m_axi_bvalid && m_axi_bready) begin
                        m_axi_bready <= 1'b0;

                        if (m_axi_bresp != 2'b00)
                            error <= 1'b1;
                        else
                            error <= 1'b0;

                        write_done <= 1'b1;
                        state <= IDLE;
                    end
                end

                READ: begin

                    if (m_axi_arvalid && m_axi_arready) begin
                        m_axi_arvalid <= 1'b0;
                        m_axi_rready <= 1'b1;

                        state <= READ_DATA;
                    end
                end

                READ_DATA: begin

                    if (m_axi_rvalid && m_axi_rready) begin
                        read_data <= m_axi_rdata;

                        if (m_axi_rresp != 2'b00)
                            error <= 1'b1;
                        else
                            error <= 1'b0;

                        m_axi_rready <= 1'b0;
                        read_done <= 1'b1;

                        state <= IDLE;
                    end
                end

                default: begin
                    state <= IDLE;
                end

            endcase
        end
    end

endmodule