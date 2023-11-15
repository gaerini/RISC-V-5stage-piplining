module DMEM(
    input [31:0] addr,
    input [31:0] write_data,
    input mem_write, mem_read, clk, reset,

    output reg [31:0] read_data
);
    reg [31:0] data_mem [0:1023];
    integer i;

    always @(*) begin 
        if(mem_read) begin
            read_data <= data_mem[addr];
        end
    end

    always@(posedge clk) begin
        if(reset) begin 
            for(i=0; i<1024; i++) begin 
                data_mem[i] <= 32'd0;
            end
        end
        if(mem_write) begin
            data_mem[addr] <= write_data;
        end
        
        
    end

endmodule