`timescale 1ns / 1ps

module onehot_to_binary_tb;

    logic [15:0] onehot;
    logic [3:0] binary;
    logic valid;

    onehot_to_binary dut (

        .onehot(onehot),
        .binary(binary),
        .valid(valid)

    );

    initial begin

        $dumpfile("onehot_to_binary.vcd");
        $dumpvars(0, onehot_to_binary_tb);

        $display("One-Hot              | Binary | Valid");
        $display("--------------------------------------");

        onehot = 16'b0000000000000001; #10;
        $display("%016b | %04b | %b", onehot, binary, valid);

        repeat (15) begin
            onehot = onehot << 1;
            #10;
            $display("%016b | %04b | %b", onehot, binary, valid);
        end

        // Invalid examples
        onehot = 16'b0000000000000000; #10;
        $display("%016b | %04b | %b", onehot, binary, valid);

        onehot = 16'b0000000000000011; #10;
        $display("%016b | %04b | %b", onehot, binary, valid);

        $finish;

    end

endmodule