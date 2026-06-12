module pcup(pc_next,alu_op,pc,A,imm,Branch_taken,branch);
input [3:0]alu_op;
input [31:0]pc,imm,A;
input Branch_taken,branch;
output reg [31:0] pc_next;
always@(*) 
    case (alu_op)
    4'b0000: pc_next=pc+32'd4;
    4'b0001: pc_next=pc+32'd4;
    4'b0010: pc_next=pc+32'd4;
    4'b0011: pc_next=pc+32'd4;
    4'b0100:begin
                if (Branch_taken==1 && branch==1)
                    pc_next=pc+imm;
                else pc_next=pc+32'd4;
            end
    4'b0101: pc_next=pc+imm;
    4'b0110: pc_next=(A + imm) & ~32'd1;
    4'b0111: pc_next=pc+32'd4;
    4'b1000: pc_next=pc+32'd4;
    default: pc_next=pc+32'd4;
    endcase
endmodule