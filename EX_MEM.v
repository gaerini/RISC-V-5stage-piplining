module EX_MEM(
    input clk, reset,
    input [31:0] PC_Imm_E,
    input ZeroE,
    input [31:0] ALUResultE,
    input [31:0] read_data_2_E,
    input RegWriteE, MemtoRegE,
    input BranchE, MemReadE, MemWriteE,
    input [4:0] Rd,
    input [31:0] Inst_E,

    output reg [31:0] PC_Imm_M,
    output reg ZeroM,
    output reg [31:0] ALUResultM,
    output reg [31:0] read_data_2_M,
    output reg RegWriteM, MemtoRegM,
    output reg BranchM, MemReadM, MemWriteM,
    output reg [4:0] EX_MEM_Reg_Rd,
    output reg[31:0] Inst_M
);

always @(posedge clk) begin 
    if(reset) begin 
        PC_Imm_M <= 32'd0;
        ZeroM <= 1'b0;
        ALUResultM <= 32'd0;
        read_data_2_M <= 32'd0;
        RegWriteM <= 1'b0;
        MemtoRegM <= 1'b0;
        BranchM <= 1'b0;
        MemReadM <= 1'b0;
        MemWriteM <= 1'b0;
        EX_MEM_Reg_Rd <= 5'd0;
        Inst_M <= 32'd0;
    end
    else begin
        PC_Imm_M <= PC_Imm_E;
        ZeroM <= ZeroE;
        ALUResultM <= ALUResultE;
        read_data_2_M <= read_data_2_E;
        RegWriteM <= RegWriteE;
        MemtoRegM <= MemtoRegE;
        BranchM <= BranchE;
        MemReadM <= MemReadE;
        MemWriteM <= MemWriteE;
        EX_MEM_Reg_Rd <= Rd;
        Inst_M <= Inst_E;
    end
end
endmodule