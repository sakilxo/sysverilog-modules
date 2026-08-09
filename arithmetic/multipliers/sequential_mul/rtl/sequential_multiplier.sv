`timescale 1ns / 1ps

module sequential_multiplier #(
    parameter WIDTH = 4
) (
    input  logic             clk,
    input  logic             rst,
    input  logic             start,

    input  logic [WIDTH-1:0] multiplicand,
    input  logic [WIDTH-1:0] multiplier,

    output logic [(2*WIDTH)-1:0] product,
    output logic             done
);

    logic [WIDTH-1:0] multiplicand_reg;
    logic [WIDTH-1:0] multiplier_reg;

    logic [(2*WIDTH)-1:0] accumulator;

    logic [$clog2(WIDTH+1)-1:0] count;

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            multiplicand_reg <= '0;
            multiplier_reg   <= '0;
            accumulator      <= '0;

            count   <= '0;
            product <= '0;
            done    <= 1'b0;

        end
        else begin

            done <= 1'b0;

            if (start) begin

                multiplicand_reg <= multiplicand;
                multiplier_reg   <= multiplier;

                accumulator <= '0;

                count <= '0;

            end
            else if (count < WIDTH) begin

                if (multiplier_reg[0]) begin
                    accumulator <= accumulator +
                                   {{WIDTH{1'b0}}, multiplicand_reg};
                end

                multiplicand_reg <= multiplicand_reg << 1;
                multiplier_reg   <= multiplier_reg >> 1;

                count <= count + 1'b1;

                if (count == WIDTH-1) begin

                    if (multiplier_reg[0]) begin
                        product <= accumulator +
                                   {{WIDTH{1'b0}}, multiplicand_reg};
                    end
                    else begin
                        product <= accumulator;
                    end

                    done <= 1'b1;

                end

            end

        end

    end

endmodule