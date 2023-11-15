module Hazard_detection(
    input ID_EX_MemRead,
    input [4:0] ID_EX_RegRd,
    input [4:0] IF_ID_RegRs1,
    input [4:0] IF_ID_RegRs2,
    output reg stall_PC,
    output reg stall_IF_ID
);

always @(*) begin 
    if(ID_EX_MemRead && ((ID_EX_RegRd == IF_ID_RegRs1)||(ID_EX_RegRd == IF_ID_RegRs2))) begin 
        stall_PC <= 1'b1;
        stall_IF_ID <= 1'b1;
    end
    else begin 
        stall_PC <= 1'b0;
        stall_IF_ID <= 1'b0;
    end
end

endmodule