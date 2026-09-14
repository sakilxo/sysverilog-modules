`timescale 1ns / 1ps

module axi_lite_slave_tb;

    localparam ADDR_WIDTH = 4;
    localparam DATA_WIDTH = 32;

    logic clk;
    logic rst;

    logic [ADDR_WIDTH-1:0] s_axi_awaddr;
    logic                  s_axi_awvalid;
    logic                  s_axi_awready;

    logic [DATA_WIDTH-1:0] s_axi_wdata;
    logic [DATA_WIDTH/8-1:0] s_axi_wstrb;
    logic                  s_axi_wvalid;
    logic                  s_axi_wready;

    logic [1:0] s_axi_bresp;
    logic       s_axi_bvalid;
    logic       s_axi_bready;

    logic [ADDR_WIDTH-1:0] s_axi_araddr;
    logic                  s_axi_arvalid;
    logic                  s_axi_arready;

    logic [DATA_WIDTH-1:0] s_axi_rdata;
    logic [1:0]            s_axi_rresp;
    logic                  s_axi_rvalid;
    logic                  s_axi_rready;

    axi_lite_slave #(
        .ADDR_WIDTH(ADDR_WIDTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) dut (
        .clk           (clk),
        .rst           (rst),

        .s_axi_awaddr  (s_axi_awaddr),
        .s_axi_awvalid (s_axi_awvalid),
        .s_axi_awready (s_axi_awready),

        .s_axi_wdata   (s_axi_wdata),
        .s_axi_wstrb   (s_axi_wstrb),
        .s_axi_wvalid  (s_axi_wvalid),
        .s_axi_wready  (s_axi_wready),

        .s_axi_bresp   (s_axi_bresp),
        .s_axi_bvalid  (s_axi_bvalid),
        .s_axi_bready  (s_axi_bready),

        .s_axi_araddr  (s_axi_araddr),
        .s_axi_arvalid (s_axi_arvalid),
        .s_axi_arready (s_axi_arready),

        .s_axi_rdata   (s_axi_rdata),
        .s_axi_rresp   (s_axi_rresp),
        .s_axi_rvalid  (s_axi_rvalid),
        .s_axi_rready  (s_axi_rready)
    );

    always #5 clk = ~clk;

    task axi_write(
        input logic [ADDR_WIDTH-1:0] addr,
        input logic [DATA_WIDTH-1:0] data
    );
        begin
            // Write address
            @(posedge clk);
            s_axi_awaddr  <= addr;
            s_axi_awvalid <= 1'b1;

            wait (s_axi_awready);

            @(posedge clk);
            s_axi_awvalid <= 1'b0;

            // Write data
            s_axi_wdata  <= data;
            s_axi_wstrb  <= 4'b1111;
            s_axi_wvalid <= 1'b1;

            wait (s_axi_wready);

            @(posedge clk);
            s_axi_wvalid <= 1'b0;

            // Response
            s_axi_bready <= 1'b1;

            wait (s_axi_bvalid);

            @(posedge clk);
            s_axi_bready <= 1'b0;

            $display(
                "AXI WRITE: ADDR=%h DATA=%h RESP=%b",
                addr,
                data,
                s_axi_bresp
            );
        end
    endtask

    task axi_read(
        input logic [ADDR_WIDTH-1:0] addr
    );
        begin
            @(posedge clk);

            s_axi_araddr  <= addr;
            s_axi_arvalid <= 1'b1;

            wait (s_axi_arready);

            @(posedge clk);
            s_axi_arvalid <= 1'b0;

            s_axi_rready <= 1'b1;

            wait (s_axi_rvalid);

            @(posedge clk);

            $display(
                "AXI READ: ADDR=%h DATA=%h RESP=%b",
                addr,
                s_axi_rdata,
                s_axi_rresp
            );

            s_axi_rready <= 1'b0;
        end
    endtask

    initial begin
        clk = 1'b0;
        rst = 1'b1;

        s_axi_awaddr  = '0;
        s_axi_awvalid = 1'b0;

        s_axi_wdata   = '0;
        s_axi_wstrb   = 4'b0000;
        s_axi_wvalid  = 1'b0;

        s_axi_bready  = 1'b0;

        s_axi_araddr  = '0;
        s_axi_arvalid = 1'b0;

        s_axi_rready  = 1'b0;

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