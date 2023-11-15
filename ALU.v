module ALU(ALUControl, A, B, ALUResult, Zero);
    input[3:0] ALUControl;
    input signed [31:0] A, B;

    output reg signed [31:0] ALUResult;
    output reg Zero;

    //RTYPE: ADD, SUB, AND, OR, SLL, SRL, SRA
    //BTYPE: BEQ, BNE
    //ITYPE: LW, ADDI, ORI, ANDI
    //STYPE: SW

    wire signed [31:0] ADD, SUB, AND, OR, SLL, SRL, SRA;
    
    
    assign ADD = A + B;
    assign SUB = A - B;
    assign AND = A & B;
    assign OR = A | B;
    assign SLL = A << B;
    assign SRL = A >> B;
    assign SRA = A >>> B;

    always@(*)
    begin
        case(ALUControl)
            4'b0000: ALUResult <= AND;
            4'b0001: ALUResult <= OR;
            4'b0010: ALUResult <= ADD;
            4'b0110: ALUResult <= SUB;
            4'b0011: ALUResult <= SLL;
            4'b0100: ALUResult <= SRL;
            4'b0101: ALUResult <= SRA;
        endcase

        if(ALUResult == 32'b0)
        begin 
            Zero <= 1'b1;
        end else begin 
            Zero <= 1'b0;
        end
    end


endmodule