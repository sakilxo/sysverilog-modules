`timescale 1ns / 1ps

module register_file_tb;

    parameter DATA_WIDTH = 32;
    parameter ADDR_WIDTH = 5;

    logic                  clk;
    logic                  rst;

    logic [ADDR_WIDTH-1:0] read_addr1;
    logic [ADDR_WIDTH-1:0] read_addr2;

    logic [DATA_WIDTH-1:0] read_data1;
    logic [DATA_WIDTH-1:0] read_data2;

    logic [ADDR_WIDTH-1:0] write_addr;
    logic [DATA_WIDTH-1:0] write_data;

    logic                  write_enable;


    register_file #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) dut (

        .clk(clk),
        .rst(rst),

        .read_addr1(read_addr1),
        .read_addr2(read_addr2),

        .read_data1(read_data1),
        .read_data2(read_data2),

        .write_addr(write_addr),
        .write_data(write_data),

        .write_enable(write_enable)

    );


    always #5 clk = ~clk;


    task write_register(
        input logic [ADDR_WIDTH-1:0] addr,
        input logic [DATA_WIDTH-1:0] data
    );

        begin

            @(negedge clk);

            write_addr   = addr;
            write_data   = data;
            write_enable = 1'b1;

            @(negedge clk);

            write_enable = 1'b0;

        end

    endtask


    task read_registers(
        input logic [ADDR_WIDTH-1:0] addr1,
        input logic [ADDR_WIDTH-1:0] addr2
    );

        begin

            read_addr1 = addr1;
            read_addr2 = addr2;

            #2;

            $display(
                "R[%0d] = %h | R[%0d] = %h",
                addr1,
                read_data1,
                addr2,
                read_data2
            );

        end

    endtask


    initial begin

        $dumpfile("register_file.vcd");
        $dumpvars(0, register_file_tb);


        clk = 1'b0;
        rst = 1'b1;

        read_addr1 = '0;
        read_addr2 = '0;

        write_addr   = '0;
        write_data   = '0;
        write_enable = 1'b0;


        /*
         * Reset
         */
        #12;

        rst = 1'b0;


        /*
         * Write registers
         */
        write_register(5'd1, 32'h12345678);
        write_register(5'd2, 32'hDEADBEEF);
        write_register(5'd5, 32'hCAFEBABE);
        write_register(5'd10, 32'h11223344);


        /*
         * Read two registers simultaneously
         */
        read_registers(5'd1, 5'd2);

        read_registers(5'd5, 5'd10);

        read_registers(5'd1, 5'd5);


        /*
         * Read an unwritten register
         */
        read_registers(5'd20, 5'd0);


        /*
         * Overwrite register 1
         */
        write_register(5'd1, 32'hAAAAAAAA);

        read_registers(5'd1, 5'd2);


        #20;

        $finish;

    end

endmodule