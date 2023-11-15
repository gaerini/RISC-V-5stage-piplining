module Branch_Adder(
    input [31:0] PC,
    input signed [31:0] Imm,

    output [31:0] PC_target
);

    wire [31:0] PC_shifted;
    assign PC_shifted = Imm >>> 1;
    assign PC_target = PC + PC_shifted;

endmodule