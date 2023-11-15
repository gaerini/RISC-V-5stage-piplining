module MUX_Branch(
    input Branch, Zero,
    input [2:0] funct3,
    output reg branch_res
);

wire temp_beq = Branch & Zero;
wire temp_bne = Branch ^ Zero;

assign temp_beq = Branch & Zero;
always @(*) begin 
    case(funct3)
        3'b000: branch_res <= temp_beq;
        3'b001: branch_res <= temp_bne;
    endcase
end

endmodule