module writedata(write_data,pc,imm,alu_op,alu_result,read_data);
input [31:0]pc,imm;
input [3:0]alu_op;
input [31:0]alu_result,read_data;
output reg [31:0]write_data;
always@(*) 
    case(alu_op)
    4'b0000: write_data=alu_result;
    4'b0001: write_data=alu_result;
    4'b0010: write_data=read_data;
    4'b0011: write_data=alu_result;
    4'b0100: write_data=alu_result;
    4'b0101: write_data=pc+32'd4;
    4'b0110: write_data=pc+32'd4;
    4'b0111: write_data=imm;
    4'b1000: write_data=pc+imm;
    default: write_data=alu_result;
    endcase
endmodule