module ID_EX(
    input clk, reset,
    input [31:0] PCD,
    input [31:0] read_data_1_D,
    input [31:0] read_data_2_D,
    input [31:0] ImmD,
    input [1:0] ALUOPD,
    input RegWriteD, MemtoRegD,
    input BranchD, MemReadD, MemWriteD,
    input ALUSrcD,
    input [4:0] IF_ID_Reg_Rs1,
    input [4:0] IF_ID_Reg_Rs2,
    input [4:0] IF_ID_Reg_Rd,
    input [31:0] Inst_D,
    input stall,

    output reg [31:0] PCE,
    output reg [31:0] ImmE,
    output reg [31:0] read_data_1_E,
    output reg [31:0] read_data_2_E,
    output reg [1:0] ALUOPE,
    output reg RegWriteE, MemtoRegE,
    output reg BranchE, MemReadE, MemWriteE,
    output reg ALUSrcE,
    output reg [4:0] Rs1,
    output reg [4:0] Rs2,
    output reg [4:0] Rd,
    output reg [31:0] Inst_E
);


always @(posedge clk) begin
    if(reset) begin 
        PCE <= PCD;
        read_data_1_E <= 32'd0;
        read_data_2_E <= 32'd0;
        ImmE <= 32'd0;
        RegWriteE <= 1'b0;
        MemtoRegE <= 1'b0;
        BranchE <= 1'b0;
        MemReadE <= 1'b0;
        MemWriteE <= 1'b0;
        ALUSrcE <= 1'b0;
        ALUOPE <= 2'd0;
        Rs1 <= 5'd0;
        Rs2 <= 5'd0;
        Rd <= 5'd0;
        Inst_E <= 31'd0;
    end 
    else if(stall) begin 
        PCE <= PCD;
        read_data_1_E <= read_data_1_E;
        read_data_2_E <= read_data_2_E;
        ImmE <= ImmE;
        RegWriteE <= 1'b0;
        MemtoRegE <= 1'b0;
        BranchE <= 1'b0;
        MemReadE <= 1'b0;
        MemWriteE <= 1'b0;
        ALUSrcE <= 1'b0;
        ALUOPE <= 2'd0;
        Rs1 <= Rs1;
        Rs2 <= Rs2;
        Rd <= Rd;
        Inst_E <= Inst_E;
    end
    else begin
        PCE <= PCD;
        read_data_1_E <= read_data_1_D;
        read_data_2_E <= read_data_2_D;
        ImmE <= ImmD;
        RegWriteE <= RegWriteD;
        MemtoRegE <= MemtoRegD;
        BranchE <= BranchD;
        MemReadE <= MemReadD;
        MemWriteE <= MemWriteD;
        ALUSrcE <= ALUSrcD;
        ALUOPE <= ALUOPD;
        Rs1 <= IF_ID_Reg_Rs1;
        Rs2 <= IF_ID_Reg_Rs2;
        Rd <= IF_ID_Reg_Rd;
        Inst_E <= Inst_D;
    end
end

endmodule