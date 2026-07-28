`timescale 1ns/1ps

module parameterized_encoder #(
    parameter N = 3
)(
    input  logic [(1<<N)-1:0] in,
    output logic [N-1:0] out
);

    integer i;

    always_comb begin
        out = '0;

        for (i = 0; i < (1<<N); i = i + 1) begin
            if (in[i])
                out = i[N-1:0];
        end
    end

endmodule