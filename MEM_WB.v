module MEM_WB(
    input clk, reset,
    input [31:0] read_data_M,
    input [31:0] ALUResult_M,
    input RegWriteM, MemtoRegM,
    input [4:0] EX_MEM_Reg_Rd,

    output reg [31:0] read_data_W,
    output reg [31:0] ALUResult_W,
    output reg RegWriteW, MemtoRegW,
    output reg [4:0] MEM_WB_Reg_Rd
);

always@ (posedge clk) begin 
    if(reset) begin 
        read_data_W <= 32'd0;
        ALUResult_W <= 32'd0;
        RegWriteW <= 1'b0;
        MemtoRegW <= 1'b0;
        MEM_WB_Reg_Rd <= 5'd0;
    end
    else begin 
        read_data_W <= read_data_M;
        ALUResult_W <= ALUResult_M;
        RegWriteW <= RegWriteM;
        MemtoRegW <= MemtoRegM;
        MEM_WB_Reg_Rd <= EX_MEM_Reg_Rd;
    end
end

endmodule