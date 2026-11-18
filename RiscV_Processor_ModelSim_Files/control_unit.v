// 24I-6520 Mohammad Faizan Ansari - COA Project
module control_unit(input [31:0] instruction,input BrEq,input BrLT,output reg PC_Sel,output reg [2:0] Imm_Sel,output reg RegWen,output reg BrUn,output reg Asel,
    output reg Bsel,output reg [3:0] Alu_select,output reg Mem_RW,output reg [1:0] WB_sel,output reg is_jalr);
    always @(*) begin
        PC_Sel = 0;
	is_jalr=0;
        Imm_Sel = 3'b000;
        RegWen = 0;
        BrUn = 0;
        Asel = 0;
        Bsel = 0;
        Alu_select = 4'b0000;
        Mem_RW = 0;
        WB_sel = 2'b00;

        case(instruction[6:0])
            // R-Type Instructions
            7'b0110011: begin
                RegWen = 1;
                WB_sel = 2'b01;
                Asel = 0;
                Bsel = 0;
                case(instruction[14:12])
                    3'b000: begin
                        if(instruction[31:25] == 7'b0100000)
                            Alu_select = 4'b0001; // SUB
                        else
                            Alu_select = 4'b0000; // ADD
                    end
                    3'b001: Alu_select = 4'b0010; // SLL
                    3'b010: Alu_select = 4'b0011; // SLT
                    3'b011: Alu_select = 4'b0100; // SLTU
                    3'b100: Alu_select = 4'b0101; // XOR
                    3'b101: begin
                        if(instruction[31:25] == 7'b0100000)
                            Alu_select = 4'b0111; // SRA
                        else
                            Alu_select = 4'b0110; // SRL
                    end
                    3'b110: Alu_select = 4'b1000; // OR
                    3'b111: Alu_select = 4'b1001; // AND
                endcase
            end

            // I-Type Arithmetic Instructions
            7'b0010011: begin
                RegWen = 1;
                WB_sel = 2'b01;
                Imm_Sel = 3'b000;
                Asel = 0;
                Bsel = 1;
                case(instruction[14:12])
                    3'b000: Alu_select = 4'b0000; // ADDI
                    3'b010: Alu_select = 4'b0011; // SLTI
                    3'b011: Alu_select = 4'b0100; // SLTIU
                    3'b100: Alu_select = 4'b0101; // XORI
                    3'b110: Alu_select = 4'b1000; // ORI
                    3'b111: Alu_select = 4'b1001; // ANDI
                    3'b001: Alu_select = 4'b0010; // SLLI
                    3'b101: begin
                        if(instruction[31:25] == 7'b0100000)
                            Alu_select = 4'b0111; // SRAI
                        else
                            Alu_select = 4'b0110; // SRLI
                    end
                endcase
            end

            // Load Instructions
            7'b0000011: begin
                RegWen = 1;
                Imm_Sel = 3'b000;
                Asel = 0;
                Bsel = 1;
                Alu_select = 4'b0000;
                Mem_RW = 0;
                WB_sel = 2'b00;
            end

            // Store Instructions
            7'b0100011: begin
                Imm_Sel = 3'b001;
                Asel = 0;
                Bsel = 1;
                Alu_select = 4'b0000;
                Mem_RW = 1;
            end

            // Branch Instructions
            7'b1100011: begin
                Imm_Sel = 3'b010;
                Asel = 1;
                Bsel = 1;
                Alu_select = 4'b0000;
                case(instruction[14:12])
                    3'b000: PC_Sel = BrEq;       // BEQ
                    3'b001: PC_Sel = ~BrEq;      // BNE
                    3'b100: PC_Sel = BrLT;      // BLT
                    3'b101: begin               // BGE
                        BrUn = 0;
                        PC_Sel = ~BrLT;
                    end
                    3'b110: begin               // BLTU
                        BrUn = 1;
                        PC_Sel = BrLT;
                    end
                    3'b111: begin               // BGEU
                        BrUn = 1;
                        PC_Sel = ~BrLT;
                    end
                endcase
            end

            // LUI
            7'b0110111: begin
                RegWen = 1;
                Imm_Sel = 3'b011;
                Asel = 0;
                Bsel = 1;
                Alu_select = 4'b1010; // Pass B
                WB_sel = 2'b01;
            end

            // AUIPC
            7'b0010111: begin
                RegWen = 1;
                Imm_Sel = 3'b011;
                Asel = 1;
                Bsel = 1;
                Alu_select = 4'b0000; // ADD
                WB_sel = 2'b01;
            end

            // JAL
            7'b1101111: begin
                RegWen = 1;
                PC_Sel = 1;
                Imm_Sel = 3'b100;
                Asel = 1;
                Bsel = 1;
                Alu_select = 4'b0000;
                WB_sel = 2'b10; // PC + 4
            end

            // JALR
            7'b1100111: begin
                RegWen = 1;
                PC_Sel = 1;
                Imm_Sel = 3'b000;
                Asel = 0;
                Bsel = 1;
                Alu_select = 4'b0000;
                WB_sel = 2'b10; // PC + 4
		is_jalr = 1;
            end
        endcase
    end
endmodule
