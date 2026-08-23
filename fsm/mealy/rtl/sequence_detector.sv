`timescale 1ns / 1ps

module sequence_detector (

    input  logic clk,
    input  logic rst,
    input  logic in,

    output logic detected

);

    typedef enum logic [1:0] {
        S0,     // No match
        S1,     // Matched 1
        S10,    // Matched 10
        S101    // Matched 101
    } state_t;

    state_t state, next_state;


    // State register
    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            state <= S0;
        else
            state <= next_state;

    end


    // Next-state and output logic
    always_comb begin

        next_state = S0;
        detected   = 1'b0;

        case (state)

            // Nothing matched
            S0: begin

                if (in)
                    next_state = S1;
                else
                    next_state = S0;

            end


            // Matched "1"
            S1: begin

                if (in)
                    next_state = S1;
                else
                    next_state = S10;

            end


            // Matched "10"
            S10: begin

                if (in)
                    next_state = S101;
                else
                    next_state = S0;

            end


            // Matched "101"
            S101: begin

                if (in) begin

                    // 101 + 1 = 1011
                    detected   = 1'b1;
                    next_state = S1;

                end
                else begin

                    next_state = S10;

                end

            end


            default: begin

                next_state = S0;
                detected   = 1'b0;

            end

        endcase

    end

endmodule