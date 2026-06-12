module alu_ctrl(alu_result,Branch_taken,funct7,funct3,in1,in2,alu_op);

input [31:0]in1,in2;

input [6:0]funct7;
input [2:0]funct3;

input [3:0]alu_op;

output reg [31:0]alu_result;
output reg Branch_taken;

always@(*) begin
    case(alu_op)
    4'b0000: begin                                   // R_type
        case({funct3,funct7})
            10'b0000000000: alu_result=in1 + in2; //ADD
            10'b0000100000: alu_result=in1 - in2; //SUB
            10'b1000000000: alu_result=in1 ^ in2; //XOR
            10'b1100000000: alu_result=in1 | in2; //OR
            10'b1110000000: alu_result=in1 & in2; //AND
            10'b0010000000: alu_result=in1 << in2; //SLL
            10'b1010000000: alu_result=in1 >> in2; //SRL
            10'b1010100000: alu_result=$signed(in1) >>> in2; //SRA
            10'b0100000000: alu_result=($signed(in1) < $signed(in2))?32'b1:32'b0; //SLT
            10'b0110000000: alu_result=(in1 < in2)?1:0; //SLTu
            default: alu_result=in1 + in2;
        endcase
    end         
    4'b0001: begin                                   // I_type
        case({funct3,funct7})
            10'b000xxxxxxx: alu_result=in1 + in2; //ADDI
            10'b010xxxxxxx: alu_result=($signed(in1) < $signed(in2))?32'b1:32'b0; //SLTI
            10'b011xxxxxxx: alu_result=(in1 < in2)?1:0; //SLTIu
            10'b100xxxxxxx: alu_result=in1 ^ in2; //XORI
            10'b110xxxxxxx: alu_result=in1 | in2; //ORI
            10'b111xxxxxxx: alu_result=in1 & in2; //ANDI
            10'b0010000000: alu_result=in1 << in2[4:0]; //SLLI
            10'b1010000000: alu_result=in1 >> in2[4:0]; //SLRI
            10'b1010100000: alu_result=$signed(in1) >>> in2[4:0]; //SRAI
            default: alu_result=in1 + in2;
        endcase
    end
    4'b0010: begin                                   // L_type
        case(funct3)
            3'b000: alu_result=in1 + in2; //Lb
            3'b001: alu_result=in1 + in2; //Lh
            3'b010: alu_result=in1 + in2; //Lw
            3'b100: alu_result=in1 + in2; //Lbu
            3'b101: alu_result=in1 + in2; //Lhu
            default: alu_result=in1 + in2;
        endcase
    end
    4'b0011: begin                                   // S_type
        case(funct3)
            3'b000: alu_result=in1 + in2; //Sb
            3'b001: alu_result=in1 + in2; //Sh
            3'b010: alu_result=in1 + in2; //Sw
            default: alu_result=in1 + in2;
        endcase
    end 
    4'b0100: begin                                   // B_type
        case(funct3)
            3'b000: Branch_taken=(in1==in2)?1:0; //Beq
            3'b001: Branch_taken=(in1!=in2)?1:0; //Bnq
            3'b100: Branch_taken=($signed(in1) < $signed(in2))?1:0; //Blt
            3'b101: Branch_taken=($signed(in1) >= $signed(in2))?1:0; //Bge
            3'b110: Branch_taken=(in1 < in2)?1:0;  //Bltu
            3'b111: Branch_taken=(in1 >= in2)?1:0; //Bgeu
            default:Branch_taken=0;
        endcase
    end
    default: alu_result=32'd0;
    endcase
end
endmodule