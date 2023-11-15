module Control(
    input [31:0] Inst,

    output reg [1:0] ALUOP,
    output reg Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite
);


always @(*) begin
    case({Inst[6:0]})
        //R-TYPE
        7'd51: begin 
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemtoReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b1;
            ALUOP <= 2'b10;
        end
        //I-load TYPE
        7'd3: begin 
            Branch <= 1'b0;
            MemRead <= 1'b1;
            MemtoReg <= 1'b1;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b1;
            RegWrite <= 1'b1;
            ALUOP <= 2'b00;
        end
        //I TYPE
        7'd19: begin
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemtoReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b1;
            RegWrite <= 1'b1;
            ALUOP <= 2'b10;
        end
        //S-TYPE
        7'd35: begin
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemtoReg <= 1'bx;
            MemWrite <= 1'b1;
            ALUSrc <= 1'b1;
            RegWrite <= 1'b0;
            ALUOP <= 2'b00;
         end
        //B-TYPE
        7'd99: begin 
            Branch <= 1'b1;
            MemRead <= 1'b0;
            MemtoReg <= 1'bx;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b0;
            ALUOP <= 2'b01;
        end
        default: begin 
            Branch <= 1'b0;
            MemRead <= 1'b0;
            MemtoReg <= 1'b0;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b0;
            ALUOP <= 2'b00;
        end
    endcase
end

endmodule