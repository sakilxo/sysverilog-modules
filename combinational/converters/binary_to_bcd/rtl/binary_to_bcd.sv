`timescale 1ns / 1ps

module binary_to_bcd (

    input  logic [3:0] binary,

    output logic [3:0] tens,
    output logic [3:0] ones

);

    always_comb begin

        if (binary >= 10) begin
            tens = 4'd1;
            ones = binary - 4'd10;
        end
        else begin
            tens = 4'd0;
            ones = binary;
        end

    end

endmodule