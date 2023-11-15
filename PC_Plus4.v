module PC_Plus4(
    input [31:0] PC_in,
    output reg [31:0] PC_plus4
);
    always @(*) begin 
        PC_plus4 <= PC_in + 32'd4;
    end
endmodule