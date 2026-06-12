module control_unit(opcode,reg_write,mem_read,mem_write,alusrc,branch,alu_op);
input [6:0] opcode;
output reg reg_write, mem_read, mem_write;
output reg alusrc, branch;
output reg [3:0] alu_op;
    always @(*) begin
        case (opcode)
            7'b0110011: begin // R-type
                reg_write = 1; alusrc = 0;
                mem_read = 0; mem_write = 0; branch = 0;
                alu_op = 4'b0000;
            end
            7'b0010011: begin // I-type
                reg_write = 1; alusrc = 1;
                mem_read = 0; mem_write = 0; branch = 0;
                alu_op = 4'b0001;
            end
            7'b0000011: begin // LW
                reg_write = 1; alusrc = 1;
                mem_read = 1; mem_write = 0; branch = 0;
                alu_op = 4'b0010;
            end
            7'b0100011: begin // SW
                reg_write = 0; alusrc = 1;
                mem_read = 0; mem_write = 1; branch = 0;
                alu_op = 4'b0011;
            end
            7'b1100011: begin // BEQ
                reg_write = 0; alusrc = 0;
                mem_read = 0; mem_write = 0; branch = 1;
                alu_op = 4'b0100;
            end
            7'b1101111: begin // JUMP and link
                reg_write = 1; alusrc = 1;
                mem_read = 0; mem_write = 0; branch = 0;
                alu_op=4'b0101;
            end
             7'b1100111: begin // JUMP and link register
                reg_write = 1; alusrc = 1;
                mem_read = 0; mem_write = 0; branch = 0;
                alu_op=4'b0110;
            end
            7'b0110111: begin // LUI type
                reg_write = 1; alusrc = 1;
                mem_read = 0; mem_write = 0; branch = 0;
                alu_op=4'b0111;
            end
            7'b0010111: begin // AUIPC type
                reg_write = 1; alusrc = 1;
                mem_read = 0; mem_write = 0; branch = 0;
                alu_op=4'b1000;
            end
            default: begin
                reg_write = 0; alusrc = 0;
                mem_read = 0; mem_write = 0; branch = 0;
                alu_op = 4'b0000;
            end
        endcase
    end
endmodule