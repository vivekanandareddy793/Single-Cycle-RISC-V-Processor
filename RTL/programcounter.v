module pc(pc,clk,reset,pc_next);
input clk,reset;
input [31:0]pc_next;
output reg [31:0]pc;

always@(posedge clk or posedge reset) begin
    if(reset==1)
        pc<=0;
    else 
        pc<=pc_next;
end
endmodule