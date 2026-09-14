`timescale 1ns / 1ps

module axi_lite_master_tb;

    localparam ADDR_WIDTH = 4;
    localparam DATA_WIDTH = 32;

    logic clk;
    logic rst;

    logic write_start;
    logic read_start;

    logic [ADDR_WIDTH-1:0] write_addr;
    logic [DATA_WIDTH-1:0] write_data;
    logic [DATA_WIDTH/8-1:0] write_strb;

    logic [ADDR_WIDTH-1:0] read_addr;

    logic [DATA_WIDTH-1:0] read_data;
    logic write_done;
    logic read_done;
    logic error;

    logic [ADDR_WIDTH-1:0] m_axi_awaddr;
    logic m_axi_awvalid;
    logic m_axi_awready;

    logic [DATA_WIDTH-1:0] m_axi_wdata;
    logic [DATA_WIDTH/8-1:0] m_axi_wstrb;
    logic m_axi_wvalid;
    logic m_axi_wready;

    logic [1:0] m_axi_bresp;
    logic m_axi_bvalid;
    logic m_axi_bready;

    logic [ADDR_WIDTH-1:0] m_axi_araddr;
    logic m_axi_arvalid;
    logic m_axi_arready;

    logic [DATA_WIDTH-1:0] m_axi_rdata;
    logic [1:0] m_axi_rresp;
    logic m_axi_rvalid;
    logic m_axi_rready;

    logic [31:0] registers [0:3];

    integer i;

    axi_lite_master #(
        .ADDR_WIDTH(ADDR_WIDTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) dut (
        .clk(clk),
        .rst(rst),

        .write_start(write_start),
        .read_start(read_start),

        .write_addr(write_addr),
        .write_data(write_data),
        .write_strb(write_strb),

        .read_addr(read_addr),

        .read_data(read_data),
        .write_done(write_done),
        .read_done(read_done),
        .error(error),

        .m_axi_awaddr(m_axi_awaddr),
        .m_axi_awvalid(m_axi_awvalid),
        .m_axi_awready(m_axi_awready),

        .m_axi_wdata(m_axi_wdata),
        .m_axi_wstrb(m_axi_wstrb),
        .m_axi_wvalid(m_axi_wvalid),
        .m_axi_wready(m_axi_wready),

        .m_axi_bresp(m_axi_bresp),
        .m_axi_bvalid(m_axi_bvalid),
        .m_axi_bready(m_axi_bready),

        .m_axi_araddr(m_axi_araddr),
        .m_axi_arvalid(m_axi_arvalid),
        .m_axi_arready(m_axi_arready),

        .m_axi_rdata(m_axi_rdata),
        .m_axi_rresp(m_axi_rresp),
        .m_axi_rvalid(m_axi_rvalid),
        .m_axi_rready(m_axi_rready)
    );

    always #5 clk = ~clk;

    // Slave always ready to accept requests
    assign m_axi_awready = 1'b1;
    assign m_axi_wready  = 1'b1;
    assign m_axi_arready = 1'b1;

    // Simple slave write response
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            m_axi_bvalid <= 1'b0;
            m_axi_bresp  <= 2'b00;

            m_axi_rvalid <= 1'b0;
            m_axi_rdata  <= 32'd0;
            m_axi_rresp  <= 2'b00;

            for (i = 0; i < 4; i = i + 1)
                registers[i] <= 32'd0;
        end else begin

            // Write transaction
            if (m_axi_awvalid && m_axi_awready &&
                m_axi_wvalid && m_axi_wready) begin

                registers[m_axi_awaddr[3:2]] <= m_axi_wdata;

                m_axi_bvalid <= 1'b1;
                m_axi_bresp  <= 2'b00;
            end

            if (m_axi_bvalid && m_axi_bready)
                m_axi_bvalid <= 1'b0;

            // Read transaction
            if (m_axi_arvalid && m_axi_arready) begin
                m_axi_rdata  <= registers[m_axi_araddr[3:2]];
                m_axi_rresp  <= 2'b00;
                m_axi_rvalid <= 1'b1;
            end

            if (m_axi_rvalid && m_axi_rready)
                m_axi_rvalid <= 1'b0;
        end
    end

    task axi_write(
        input logic [ADDR_WIDTH-1:0] addr,
        input logic [DATA_WIDTH-1:0] data
    );
        begin
            @(posedge clk);

            write_addr  <= addr;
            write_data  <= data;
            write_strb  <= 4'b1111;
            write_start <= 1'b1;

            @(posedge clk);
            write_start <= 1'b0;

            wait (write_done);

            $display(
                "MASTER WRITE: ADDR=%h DATA=%h ERROR=%b",
                addr,
                data,
                error
            );
        end
    endtask

    task axi_read(
        input logic [ADDR_WIDTH-1:0] addr
    );
        begin
            @(posedge clk);

            read_addr  <= addr;
            read_start <= 1'b1;

            @(posedge clk);
            read_start <= 1'b0;

            wait (read_done);

            $display(
                "MASTER READ: ADDR=%h DATA=%h ERROR=%b",
                addr,
                read_data,
                error
            );
        end
    endtask

    initial begin
        clk = 1'b0;
        rst = 1'b1;

        write_start = 1'b0;
        read_start  = 1'b0;

        write_addr = '0;
        write_data = '0;
        write_strb = 4'b0000;
        read_addr  = '0;

        #20;
        rst = 1'b0;

        // Write register 0
        axi_write(4'h0, 32'h12345678);

        // Write register 1
        axi_write(4'h4, 32'hDEADBEEF);

        // Read register 0
        axi_read(4'h0);

        // Read register 1
        axi_read(4'h4);

        #30;

        $finish;
    end

endmodule