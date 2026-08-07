`timescale 1ns / 1ps

module booth_multiplier #(
    parameter WIDTH = 4
) (
    input  logic                   clk,
    input  logic                   rst,
    input  logic                   start,

    input  logic signed [WIDTH-1:0] multiplicand,
    input  logic signed [WIDTH-1:0] multiplier,

    output logic signed [(2*WIDTH)-1:0] product,
    output logic                   done
);

    logic signed [(2*WIDTH)-1:0] accumulator;
    logic signed [(2*WIDTH)-1:0] multiplicand_reg;
    logic signed [WIDTH-1:0]      multiplier_reg;

    logic q_minus_1;

    logic [$clog2(WIDTH+1)-1:0] count;

    logic signed [(2*WIDTH)-1:0] accumulator_next;
    logic signed [(2*WIDTH)-1:0] shifted_accumulator;
    logic signed [WIDTH-1:0] shifted_multiplier;

    always_comb begin

        accumulator_next = accumulator;

        case ({multiplier_reg[0], q_minus_1})

            2'b01:
                accumulator_next = accumulator + multiplicand_reg;

            2'b10:
                accumulator_next = accumulator - multiplicand_reg;

            default:
                accumulator_next = accumulator;

        endcase

        shifted_accumulator = accumulator_next >>> 1;

        shifted_multiplier = multiplier_reg >>> 1;

        shifted_multiplier[WIDTH-1] =
            accumulator_next[0];

    end

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            accumulator     <= '0;
            multiplicand_reg <= '0;
            multiplier_reg   <= '0;

            q_minus_1 <= 1'b0;

            count <= '0;

            product <= '0;
            done    <= 1'b0;

        end
        else begin

            done <= 1'b0;

            if (start) begin

                accumulator      <= '0;
                multiplicand_reg <= {{WIDTH{multiplicand[WIDTH-1]}}, multiplicand};
                multiplier_reg   <= multiplier;

                q_minus_1 <= 1'b0;

                count <= '0;

            end
            else if (count < WIDTH) begin

                accumulator   <= shifted_accumulator;
                multiplier_reg <= shifted_multiplier;

                q_minus_1 <= multiplier_reg[0];

                count <= count + 1'b1;

                if (count == WIDTH-1) begin

                    product <= {
                        shifted_accumulator[WIDTH-1:0],
                        shifted_multiplier
                    };

                    done <= 1'b1;

                end

            end

        end

    end

endmodule