module MUX32bit2to1(
    input [31:0] I0,
    input [31:0] I1,
    input sel,

    output reg [31:0] out
);
always@ (*) begin 
        case(sel) 
            1'b0: out <= I0;
            1'b1: out <= I1;
        endcase
    end
endmodule