module DataPath(
    input clk, reset,
    output wire [31:0] checkx1,
    output wire [31:0] checkx2,
    output wire [31:0] checkx3,
    output wire [31:0] checkx4,
    output wire [31:0] checkx5,
    output wire [31:0] checkx6
);

    wire PC_Src;
    wire [31:0] PC_out;

    wire [31:0] Inst;

    wire [31:0] Inst_D;
    wire [31:0] PC_D;

    wire RegWrite_M;
    wire [4:0] read_reg1;
    wire [4:0] read_reg2;
    wire [4:0] write_reg;
    wire [31:0] write_data;
    wire [31:0] read_data1;
    wire [31:0] read_data2;

    wire [1:0] ALUOP_D;
    wire Branch_D;
    wire MemRead_D;
    wire MemtoReg_D;
    wire MemWrite_D;
    wire ALUSrc_D;
    wire RegWrite_D;

    wire [31:0] Imm_D;

    wire [31:0] PC_E;
    wire [31:0] Imm_E;
    wire [31:0] read_data1_E;
    wire [31:0] read_data2_E;
    wire [1:0] ALUOP_E;
    wire RegWrite_E;
    wire MemtoReg_E;
    wire Branch_E;
    wire MemRead_E;
    wire MemWrite_E;
    wire ALUSrc_E;
    wire [4:0] Rs1;
    wire [4:0] Rs2;
    wire [4:0] Rd;
    wire [31:0] Inst_E;

    wire[31:0] DMEM_out;
    wire[31:0] ALUResult_M;
    wire[1:0] ForwardA;
    wire [31:0] ALU_1;

    wire [1:0] ForwardB;
    wire [31:0] ALU_2;

    wire [3:0] ALUControl;

    wire Zero;
    wire [31:0] ALUResult;

    wire [31:0] Inst_M;
    wire [31:0] PC_M;
    wire Zero_M;
    wire [31:0] read_data2_M;
    wire MemtoReg_M;
    wire Branch_M;
    wire MemRead_M;
    wire MemWrite_M;
    wire [4:0] EX_MEM_Reg_Rd;

    wire [31:0] read_data;

    wire [31:0] read_data_W;
    wire [31:0] ALUResult_W;
    wire RegWrite_W;
    wire MemtoReg_W;
    wire [4:0] MEM_WB_Reg_Rd;

    wire [31:0] PCadd;
    wire [31:0] forwarding_to_mux;

    wire [31:0] PC_F;
    wire stall_IF_ID, stall_PC;
    wire [31:0] plused_pc;
    assign read_reg1 = Inst_D[19:15];
    assign read_reg2 = Inst_D[24:20];
    assign write_reg = Inst_D[11:7];
    // assign PC_Src = Branch_M & Zero_M;

    MUX_Branch i_MUX_Branch(Branch_M, Zero_M, Inst_M[14:12], PC_Src);

    Branch_Adder i_Branch_Adder(PC_E, Imm_E, PCadd);
    // Basic_PC i_pc (PC_M, PC_Src, PC_out, clk, reset);
    MUX32bit2to1 i_pcmux(plused_pc ,PC_M, PC_Src, PC_F);
    PC_Plus4 i_PC_Plus4(PC_out, plused_pc);
    Basic_PC i_pc (PC_F, PC_out, stall_PC, clk, reset);
    
    IMEM i_imem (PC_out, Inst);


    IF_ID i_IF_ID(clk, reset, stall_IF_ID, Inst, PC_out, Inst_D, PC_D);

    RegFile i_RegFile(
        clk, 
        reset, 
        RegWrite_W, 
        read_reg1, 
        read_reg2, 
        MEM_WB_Reg_Rd, 
        write_data, 
        read_data1, 
        read_data2,
        checkx1,
        checkx2,
        checkx3,
        checkx4,
        checkx5,
        checkx6
        );


    Control i_Control(
        Inst_D, 
        ALUOP_D, 
        Branch_D, 
        MemRead_D, 
        MemtoReg_D, 
        MemWrite_D, 
        ALUSrc_D, 
        RegWrite_D
        );

    ImmGen i_ImmGen(Inst_D, Imm_D);

    Hazard_detection i_hazard_detection(MemRead_E, Rd, read_reg1, read_reg2, stall_PC, stall_IF_ID);

    ID_EX i_ID_EX (
        clk, 
        reset, 
        PC_D, 
        read_data1, 
        read_data2, 
        Imm_D, 
        ALUOP_D,
        RegWrite_D, 
        MemtoReg_D,
        Branch_D, 
        MemRead_D, 
        MemWrite_D,
        ALUSrc_D,
        read_reg1,
        read_reg2,
        write_reg,
        Inst_D,
        stall_IF_ID,
        PC_E,
        Imm_E,
        read_data1_E,
        read_data2_E,
        ALUOP_E,
        RegWrite_E, 
        MemtoReg_E,
        Branch_E,
        MemRead_E, 
        MemWrite_E,
        ALUSrc_E,
        Rs1,
        Rs2,
        Rd,
        Inst_E
        );

    MUXForwarding i_MUXForwarding_A(read_data1_E, write_data, ALUResult_M, ForwardA, ALU_1);

    MUXForwarding i_MUXForwarding_B(read_data2_E, write_data, ALUResult_M, ForwardB, forwarding_to_mux);


    ALUControl i_ALUControl(Inst_E, ALUOP_E, ALUControl);

    MUX32bit2to1 i_MUX_ALU(forwarding_to_mux, Imm_E, ALUSrc_E, ALU_2);

    ALU i_ALU(ALUControl, ALU_1, ALU_2, ALUResult, Zero);


    EX_MEM i_EX_MEM(
        clk, 
        reset,
        PCadd,
        Zero,
        ALUResult,
        forwarding_to_mux,
        RegWrite_E,
        MemtoReg_E,
        Branch_E, 
        MemRead_E, 
        MemWrite_E,
        Rd,
        Inst_E,
        PC_M,
        Zero_M,
        ALUResult_M,
        read_data2_M,
        RegWrite_M,
        MemtoReg_M,
        Branch_M, 
        MemRead_M,
        MemWrite_M,
        EX_MEM_Reg_Rd,
        Inst_M
        );

    DMEM i_DMEM(
        ALUResult_M,
        read_data2_M,
        MemWrite_M, 
        MemRead_M, 
        clk, 
        reset,
        read_data
    );


    MEM_WB i_MEM_WB(
        clk, 
        reset,
        read_data,
        ALUResult_M,
        RegWrite_M, 
        MemtoReg_M,
        EX_MEM_Reg_Rd,
        read_data_W,
        ALUResult_W,
        RegWrite_W, 
        MemtoReg_W,
        MEM_WB_Reg_Rd
    );

    Forwarding_Unit i_Forwarding_Unit(
        Rs1,
        Rs2,
        EX_MEM_Reg_Rd,
        RegWrite_M, 
        MemtoReg_M,
        MEM_WB_Reg_Rd,
        RegWrite_W, 
        MemtoReg_W, //MEM_WB
        ForwardA,
        ForwardB
    );

    MUX32bit2to1 i_MUX32bit2to1(
        ALUResult_W,
        read_data_W,
        MemtoReg_W,
        write_data
    );

endmodule