module instr_fetch(instr,pc);
input [31:0]pc;
output reg [31:0]instr;
// instruction memory for fibonacci sequence
reg [31:0] mem [0:31];
initial begin
        mem[0]  = 32'h01100493;   // addi x9,  x0, 17
        mem[1]  = 32'h00000513;   // addi x10, x0, 0
        mem[2]  = 32'h00000093;   // addi x1,  x0, 0
        mem[3]  = 32'h00100093;   // addi x1,  x0, 1
        mem[4]  = 32'h00100113;   // addi x2,  x0, 1
        mem[5]  = 32'h000081b3;   // add  x3,  x1, x0
        mem[6]  = 32'h000101b3;   // add  x3,  x2, x0
        mem[7]  = 32'h001101b3;   // add  x3,  x2, x1
        mem[8]  = 32'h004005ef;   // jal  x11, 4
        mem[9]  = 32'h00a48c63;   // beq  x9, x10, 24
        mem[10] = 32'h000100b3;   // add  x1,  x2, x0
        mem[11] = 32'h00018133;   // add  x2,  x3, x0
        mem[12] = 32'h001101b3;   // add  x3,  x2, x1
        mem[13] = 32'h00150513;   // addi x10, x10, 1
        mem[14] = 32'hfedff5ef;   // jal  x11, -20
        mem[15] = 32'h000005e7;   // jalr x11, x0, 0
end
always@(*) instr = mem[pc[6:2]];
endmodule