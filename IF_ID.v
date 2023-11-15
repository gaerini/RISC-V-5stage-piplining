module IF_ID(
    input clk, reset, stall_IF_ID,
    input[31:0] Inst_in,
    input[31:0] PCF,

    output reg [31:0] Inst_out,
    output reg [31:0] PCD
);

always @(posedge clk) begin
    if(reset) begin 
        PCD <= 32'd0;
        Inst_out <= 32'd0;
    end
    else if(stall_IF_ID) begin 
        PCD <= PCD;
        Inst_out <= Inst_out;
    end
    else begin
        PCD <= PCF;
        Inst_out <= Inst_in;
    end
end


endmodule