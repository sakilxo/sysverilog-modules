module arithmetic_right_shift #(
    parameter WIDTH = 8
)(
    input  logic [WIDTH-1:0] data_in,
    input  logic [$clog2(WIDTH)-1:0] shift_amount,
    output logic [WIDTH-1:0] data_out
);

    always_comb begin
        data_out = $signed(data_in) >>> shift_amount;
    end

endmodule