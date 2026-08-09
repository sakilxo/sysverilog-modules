`timescale 1ns / 1ps

module sequential_divider #(
    parameter WIDTH = 4
) (
    input  logic             clk,
    input  logic             rst,
    input  logic             start,

    input  logic [WIDTH-1:0] dividend,
    input  logic [WIDTH-1:0] divisor,

    output logic [WIDTH-1:0] quotient,
    output logic [WIDTH-1:0] remainder,
    output logic             done
);

    logic [WIDTH-1:0] dividend_reg;
    logic [WIDTH-1:0] divisor_reg;

    logic [WIDTH:0] remainder_reg;

    logic [$clog2(WIDTH+1)-1:0] count;

    logic [WIDTH:0] shifted_remainder;
    logic [WIDTH:0] next_remainder;


    always_comb begin

        
        shifted_remainder =
            {remainder_reg[WIDTH-1:0],
             dividend_reg[WIDTH-1]};


  
        if (shifted_remainder >= {1'b0, divisor_reg}) begin

            next_remainder =
                shifted_remainder -
                {1'b0, divisor_reg};

        end
        else begin

            next_remainder =
                shifted_remainder;

        end

    end


    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            dividend_reg  <= '0;
            divisor_reg   <= '0;
            remainder_reg <= '0;

            quotient  <= '0;
            remainder <= '0;

            count <= '0;
            done  <= 1'b0;

        end
        else begin

            done <= 1'b0;


            if (start) begin

                dividend_reg  <= dividend;
                divisor_reg   <= divisor;

                remainder_reg <= '0;
                quotient      <= '0;

                count <= '0;

            end


            else if (count < WIDTH) begin

    
                dividend_reg <= dividend_reg << 1;


        
                remainder_reg <= next_remainder;


                if (shifted_remainder >= {1'b0, divisor_reg}) begin

                    quotient[WIDTH-1-count] <= 1'b1;

                end
                else begin

                    quotient[WIDTH-1-count] <= 1'b0;

                end


                count <= count + 1'b1;



                if (count == WIDTH-1) begin

                    remainder <= next_remainder[WIDTH-1:0];

                    done <= 1'b1;

                end

            end

        end

    end

endmodule