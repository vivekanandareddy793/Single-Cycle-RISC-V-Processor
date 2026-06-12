module top(an,seg,clkout,clk,reset);
output [3:0]an;
output [6:0]seg;
input clk,reset;
output clkout;
wire [31:0]result;
wire [3:0]thousands,hundreds,tens,ones,digits;

clkDivider cd(clkout,clk,reset);
processor risc(result,clkout,reset);
bintobcd con(thousands,hundreds,tens,ones,result);
displaymux dm(an,seg,thousands,hundreds,tens,ones,clk);
segment se(seg,digits);
endmodule