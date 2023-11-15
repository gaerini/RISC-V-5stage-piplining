module IMEM(addr, Inst);
    input [31:0]addr;
    output [31:0]Inst;


    reg [31:0] mem[0:1023];
    
    initial begin
        $readmemb("code_1.txt", mem, 0);
        $readmemb("code_2.txt", mem, 40); //PC 160~
        $readmemb("code_bne_taken.txt", mem, 60); //PC 240~
        $readmemb("code_beq_taken.txt", mem, 80); //PC 320~
    end

    assign Inst = mem[addr[31:2]];
    

    
endmodule