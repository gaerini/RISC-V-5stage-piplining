module ImmGen(
    input [31:0] Inst,
    output reg signed [31:0] ImmOut
);

    always@(*) begin
        case({Inst[6:0]})
            //I-load TYPE
            7'd3: ImmOut <= {{20{Inst[31]}},Inst[31:20]};
            //I-Artihmetic TYPE
            7'd19: ImmOut <= {{20{Inst[31]}},Inst[31:20]};
            //S-TYPE
            7'd35: ImmOut <= {{20{Inst[31]}},Inst[31:25], Inst[11:7]};
            //B-TYPE: calculating target address by adding pc value and 1bit left shifted Imm
            7'd99: ImmOut <= {{20{Inst[31]}}, Inst[31], Inst[7], Inst[30:25], Inst[11:8], 1'b0};
        endcase
    end

endmodule