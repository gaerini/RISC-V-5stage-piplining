// module Basic_PC(PC_Imm, PC_Src, PC_out, clk, reset);
//     input PC_Src, reset, clk;
//     input [31:0] PC_Imm;
//     output reg [31:0] PC_out;


//     reg [31:0] PC_temp;

//     always @(posedge clk) begin
        
//         if(reset) begin
//             PC_temp <= 32'b0;
//             PC_out <= 32'b0;
//         end
        
//         else begin
//             PC_temp <= PC_temp + 32'd4;
//             case(PC_Src)
//                 1'b0: PC_out <= PC_temp;
//                 1'b1: PC_out <= PC_Imm;
//             endcase
//         end
//     end
        
// endmodule

module Basic_PC(PC_in, PC_out, stall_PC, clk, reset);
    input reset, clk, stall_PC;
    input [31:0] PC_in;
    output reg [31:0] PC_out;


    always @(posedge clk) begin
        
        if(reset) begin
            PC_out <= 32'b0;
        end

        else if(stall_PC) begin 
            PC_out <= PC_out;
        end
        
        else begin
            PC_out <= PC_in;
        end
    end
endmodule
