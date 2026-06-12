module regfile(A,B,fib,clk,reg_write,write_data,rs1,rs2,rd);
input clk,reg_write;
input [31:0]write_data;
input [4:0]rs1,rs2,rd;
output [31:0]A,B,fib;

reg [31:0] registers[0:31];
integer i;
initial begin
    for (i=0;i<32;i=i+1)
        registers[i]=0;
end
always@(posedge clk) begin
    if(reg_write==1 && rd!=0) begin
        registers[rd]<=write_data;
    end
end

assign A=(rs1!=0)?registers[rs1]:32'd0;
assign B=(rs2!=0)?registers[rs2]:32'd0;
assign fib=registers[3];

endmodule