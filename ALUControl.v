module ALUControl(Inst, ALUOp, ALUControl);
    input [31:0] Inst;
    input [1:0] ALUOp;
    output reg [3:0] ALUControl;

    reg [6:0] funct7;
    reg [2:0] funct3;

    always@(*)
    begin
        funct7 <= Inst[31:25];
        funct3 <= Inst[14:12];
        case({ALUOp, funct7, funct3})
            12'b00xxxxxxxxxx: ALUControl <= 4'b0010; //lw, sw
            12'b01xxxxxxxxxx: ALUControl <= 4'b0110; //beq, bne
            12'b100000000000: ALUControl <= 4'b0010; //add
            12'b100100000000: ALUControl <= 4'b0110; //sub
            12'b100000000111: ALUControl <= 4'b0000; //and
            12'b100000000110: ALUControl <= 4'b0001; //or
            12'b100000000001: ALUControl <= 4'b0011; //sll
            12'b100000000101: ALUControl <= 4'b0100; //srl
            12'b100100000101: ALUControl <= 4'b0101; //sra
        endcase
    end

endmodule