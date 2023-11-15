module RegFile(clk, reset, RegWrite, read_reg1, read_reg2, write_reg, write_data, read_data1, read_data2, check1, check2, check3, check4, check5, check6);
    input clk, reset;
    input RegWrite;
    input [4:0]read_reg1;
    input [4:0]read_reg2;
    input [4:0]write_reg;
    input [31:0]write_data;

    output reg [31:0]read_data1;
    output reg [31:0]read_data2;

    output reg [31:0] check1;
    output reg [31:0] check2;
    output reg [31:0] check3;
    output reg [31:0] check4;
    output reg [31:0] check5;
    output reg [31:0] check6;


    reg [31:0] Register[0:1023];
    integer i;
    initial begin
        Register[0] <= 32'd0;
        Register[1] <= 32'd0;
        Register[2] <= 32'd0;
        Register[3] <= 32'd0;
        Register[4] <= 32'd0;
        Register[5] <= 32'd0;
        Register[6] <= 32'd0;
        Register[7] <= 32'd0;
        Register[8] <= 32'd0;
        Register[9] <= 32'd0;
        Register[10] <= 32'd0;
        Register[11] <= 32'd0;
        Register[12] <= 32'd0;
        Register[13] <= 32'd0;
        Register[14] <= 32'd0;
        Register[15] <= 32'd0;
        Register[16] <= 32'd0;
        Register[17] <= 32'd0;
        Register[18] <= 32'd0;
        Register[19] <= 32'd0;
        Register[20] <= 32'd0;
        Register[21] <= 32'd0;
        Register[22] <= 32'd0;
        Register[23] <= 32'd0;
        Register[24] <= 32'd0;
        Register[25] <= 32'd0;
        Register[26] <= 32'd0;
        Register[27] <= 32'd0;
        Register[28] <= 32'd0;
        Register[29] <= 32'd0;
        Register[30] <= 32'd0;
        Register[31] <= 32'd0;
    end

    always @(*)
    begin
        check1 <= Register[1];
        check2 <= Register[2];
        check3 <= Register[3];
        check4 <= Register[4];
        check5 <= Register[5];
        check6 <= Register[6];
        read_data1 = Register[read_reg1];
        read_data2 = Register[read_reg2];
    end

    always @(negedge clk) begin
        if(reset) begin
            for(i=0; i<1024; i++) begin 
                Register[i] <= 32'b0;
            end
        end 
        else begin 
            if(RegWrite) begin 
                if(write_reg != 5'd0) begin
                    Register[write_reg] <= write_data;
                end
            end
        end
    
    end

endmodule