module mem_access(read_data,mem_read,mem_data,mem_write,funct3,addr,clk);
input clk,mem_read,mem_write;
input [31:0]pc;
input [2:0]funct3;
input [31:0]mem_data,addr;
output reg [31:0]instr;
output reg [31:0]read_data;

reg [31:0] mem [0:31];
initial begin
        mem[0] = 32'd0; 
        mem[1] = 32'd0;
        mem[2] = 32'd0;
        mem[3] = 32'd0;
        mem[4] = 32'd0;
        mem[5] = 32'd0;
        mem[6] = 32'd0;
        mem[7] = 32'd0;
        mem[8] = 32'd0;
end
always@(posedge clk)begin
    if(mem_write) begin
        case(funct3)
            3'b000: mem[addr[6:2]][7:0]<=mem_data[7:0]; //Sb
            3'b001: mem[addr[6:2]][15:0]<=mem_data[15:0]; //Sh
            3'b010: mem[addr[6:2]]<=mem_data; //Sw
            default: mem[addr[6:2]]<=mem_data;
        endcase
    end
end
always@(*)begin
    if(mem_read)
        case(funct3)
            3'b000: read_data<={{24{mem[addr[6:2]][7]}},mem[addr][7:0]}; //Lb
            3'b001: read_data<={{16{mem[addr[6:2]][15]}},mem[addr][15:0]}; //Lh
            3'b010: read_data<=mem[addr[6:2]][31:0]; //Lw
            3'b100: read_data<={24'd0,mem[addr[6:2]][7:0]}; //Lbu
            3'b101: read_data<={16'd0,mem[addr[6:2]][15:0]}; //Lhu
            default: read_data<=mem[addr[6:2]];
        endcase
    else
        read_data<=0;
end

always@(*) instr = mem[pc[6:2]];

endmodule