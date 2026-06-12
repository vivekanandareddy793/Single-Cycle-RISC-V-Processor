module imm_gen(imm,alu_op,instr);

input [31:0]instr;
input [3:0]alu_op;
output reg [31:0] imm;
always @(*) begin
    case (alu_op)
            4'b0001: // I_type
                imm = {{20{instr[31]}}, instr[31:20]};
            4'b0010: // LW
                imm = {{20{instr[31]}}, instr[31:20]};
            4'b0011: // SW
                imm = {{20{instr[31]}}, instr[31:25], instr[11:7]};
            4'b0100: // BEQ
                imm = {{19{instr[31]}}, instr[31], instr[7],
                       instr[30:25], instr[11:8], 1'b0};
            4'b0101: //JUMP and link
                imm = {{11{instr[31]}}, instr[31], instr[19:12],
                       instr[20], instr[30:21], 1'b0};
            4'b0110: //JUMP and link register
                imm = {{20{instr[31]}}, instr[31:20]};
            4'b0111: //LUI
                imm = {instr[31:12],12'b0};
            4'b1000: //AUIPC
                imm = {instr[31:12],12'b0};
            default:
                imm = 32'd0;
    endcase
end
endmodule