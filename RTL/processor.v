module processor(result,clk,reset);

output [31:0]result;
input clk,reset;

wire [31:0]pc,pc_next,instr,A,B,fib,imm,in2,write_data,alu_result,read_data;
wire reg_write,mem_read,mem_write,alusrc,branch,Branch_taken;
wire [3:0]alu_op;
wire [6:0]opcode;
wire [4:0]rs1,rs2,rd;
wire [2:0]func3;
wire [6:0]func7;

pc pc_instr(pc,clk,reset,pc_next);
instr_fetch inf(instr,pc);
mem_access mema(instr,read_data,mem_read,B,mem_write,func3,alu_result,clk);
instrdecode id(opcode,rs1,rs2,rd,func3,func7,instr);
control_unit ctrl(opcode,reg_write,mem_read,mem_write,alusrc,branch,alu_op);
regfile r(A,B,fib,clk,reg_write,write_data,rs1,rs2,rd);
imm_gen immg(imm,alu_op,instr);
assign in2=alusrc?imm:B;
alu_ctrl alu(alu_result,Branch_taken,func7,func3,A,in2,alu_op);
writedata wd(write_data,pc,imm,alu_op,alu_result,read_data);
pcup pn(pc_next,alu_op,pc,A,imm,Branch_taken,branch);

assign result=fib;
endmodule