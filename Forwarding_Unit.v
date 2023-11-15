module Forwarding_Unit(
    input [4:0] Rs1,
    input [4:0] Rs2,
    input [4:0] EX_MEM_RegRd,
    input RegWriteM, MemtoRegM, //EX_MEM
    input [4:0] MEM_WB_RegRd,
    input RegWriteW, MemtoRegW, //MEM_WB


    output reg [1:0] ForwardA,
    output reg [1:0] ForwardB

);
    always @(*) begin 
        if(((EX_MEM_RegRd == Rs1) && RegWriteM) && (EX_MEM_RegRd != 5'd0)) begin 
            
            ForwardA <= 2'b10;

        end

        else if(RegWriteW && (MEM_WB_RegRd != 5'd0) && !(RegWriteM && (EX_MEM_RegRd != 0) && (EX_MEM_RegRd == Rs1)) && (MEM_WB_RegRd == Rs1)) begin 
            
            ForwardA <= 2'b01;
              
        end

        else begin 
            ForwardA <= 2'b00;
        end
    end

    always @(*) begin 
        if(((EX_MEM_RegRd != 5'd0) && RegWriteM) && (EX_MEM_RegRd == Rs2)) begin 
             
            ForwardB <= 2'b10;
                
        end

        else if(RegWriteW && (MEM_WB_RegRd != 5'd0) && !(RegWriteM && (EX_MEM_RegRd != 0) && (EX_MEM_RegRd == Rs2)) && (MEM_WB_RegRd == Rs2)) begin 
            
            ForwardB <= 2'b01;
           
        end
        else begin 
            ForwardB <= 2'b00;
        end
    end

endmodule