`timescale 1ns / 1ps

module non_restoring_divider #(
    parameter WIDTH = 4
) (
    input  logic                 clk,
    input  logic                 rst,
    input  logic                 start,

    input  logic [WIDTH-1:0]     dividend,
    input  logic [WIDTH-1:0]     divisor,

    output logic [WIDTH-1:0]     quotient,
    output logic [WIDTH-1:0]     remainder,
    output logic                 done
);

    logic signed [WIDTH:0] remainder_reg;
    logic [WIDTH-1:0]      dividend_reg;
    logic [WIDTH-1:0]      divisor_reg;

    logic [$clog2(WIDTH+1)-1:0] count;

    logic signed [WIDTH:0] shifted_remainder;
    logic signed [WIDTH:0] next_remainder;
    logic signed [WIDTH:0] corrected_remainder;


    always_comb begin

        shifted_remainder =
            remainder_reg <<< 1;

        shifted_remainder[0] =
            dividend_reg[WIDTH-1];


        if (remainder_reg >= 0) begin

            next_remainder =
                shifted_remainder -
                $signed({1'b0, divisor_reg});

        end
        else begin

            next_remainder =
                shifted_remainder +
                $signed({1'b0, divisor_reg});

        end





        if (next_remainder < 0) begin

            corrected_remainder =
                next_remainder +
                $signed({1'b0, divisor_reg});

        end
        else begin

            corrected_remainder =
                next_remainder;

        end

    end


    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            remainder_reg <= '0;
            dividend_reg  <= '0;
            divisor_reg   <= '0;

            quotient  <= '0;
            remainder <= '0;

            count <= '0;
            done  <= 1'b0;

        end
        else begin

            done <= 1'b0;


            if (start) begin

                remainder_reg <= '0;
                dividend_reg  <= dividend;
                divisor_reg   <= divisor;

                quotient <= '0;

                count <= '0;

            end


            else if (count < WIDTH) begin

                
                dividend_reg <= dividend_reg << 1;


  
                remainder_reg <= next_remainder;


 
                if (next_remainder >= 0) begin

                    quotient[WIDTH-1-count] <= 1'b1;

                end
                else begin

                    quotient[WIDTH-1-count] <= 1'b0;

                end


                count <= count + 1'b1;


 
                if (count == WIDTH-1) begin

                    remainder <= corrected_remainder[WIDTH-1:0];

                    done <= 1'b1;

                end

            end

        end

    end

endmodule