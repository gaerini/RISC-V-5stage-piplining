module MUXForwarding(
    input [31:0] I0,
    input [31:0] I1,
    input [31:0] I2,
    input [1:0] sel,

    output reg [31:0] out
);

always @(*) begin 
    case(sel) 
        2'b00: out <= I0;
        2'b01: out <= I1;
        2'b10: out <= I2;
    endcase
end
endmodule