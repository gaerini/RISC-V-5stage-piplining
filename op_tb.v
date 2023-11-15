`timescale 1ns/1ps

module op_tb;
    reg clk;
    reg reset;

    wire [31:0] x1;
    wire [31:0] x2;
    wire [31:0] x3;
    wire [31:0] x4;
    wire [31:0] x5;
    wire [31:0] x6;

    DataPath i_riscv (
        clk,
        reset,
        x1,
        x2,
        x3,
        x4,
        x5,
        x6
    );
    
    initial begin
        clk = 0;
        reset = 1;
        #7;
        reset = 0;
    end

    always #5 clk = ~clk;

    initial begin
        $dumpfile("op_tb.vcd");
        $dumpvars(0, op_tb);

        // 시뮬레이션 시간 지정
        #10000 $finish;
    end
endmodule

