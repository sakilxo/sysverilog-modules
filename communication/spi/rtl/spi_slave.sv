`timescale 1ns / 1ps

module spi_slave (
    input  logic       clk,
    input  logic       rst,

    input  logic       cs,
    input  logic       sclk,
    input  logic       mosi,

    output logic       miso,

    input  logic [7:0] data_in,
    output logic [7:0] data_out,
    output logic       valid
);

    logic [7:0] rx_shift_reg;
    logic [7:0] tx_shift_reg;
    logic [2:0] bit_count;

    logic sclk_prev;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            rx_shift_reg <= 8'd0;
            tx_shift_reg <= 8'd0;
            bit_count    <= 3'd0;
            data_out     <= 8'd0;
            miso         <= 1'b0;
            valid        <= 1'b0;
            sclk_prev    <= 1'b0;
        end else begin
            valid <= 1'b0;

            sclk_prev <= sclk;

            if (cs) begin
                // Slave not selected
                rx_shift_reg <= 8'd0;
                bit_count    <= 3'd0;
                miso         <= 1'b0;
            end else begin

                // Falling edge: change MISO
                if (sclk_prev && !sclk) begin
                    if (bit_count < 3'd7) begin
                        tx_shift_reg <= {tx_shift_reg[6:0], 1'b0};
                        miso <= tx_shift_reg[6];
                    end else begin
                        miso <= tx_shift_reg[6];
                    end
                end

                // Rising edge: sample MOSI
                if (!sclk_prev && sclk) begin
                    rx_shift_reg[bit_count] <= mosi;

                    if (bit_count == 3'd7) begin
                        data_out <= {rx_shift_reg[6:0], mosi};
                        valid <= 1'b1;
                        bit_count <= 3'd0;
                    end else begin
                        bit_count <= bit_count + 1'b1;
                    end
                end

                // Load first transmit bit
                if (!sclk_prev && sclk && bit_count == 3'd0) begin
                    tx_shift_reg <= data_in;
                    miso <= data_in[7];
                end
            end
        end
    end

endmodule