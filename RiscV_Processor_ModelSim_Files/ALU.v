// 24I-6520 Mohammad Faizan Ansari - COA Project
module ALU(input [31:0] alu_A, input [31:0] alu_B, input [3:0] ALU_select, output reg [31:0] result);
	reg [32:0] temp_slt, temp_sltu;
	reg overflow_slt;
	reg [31:0] temp;
	reg sign_bit;
	integer i, j;

	always @(*) begin
		case (ALU_select)
			4'b0000: result = alu_A + alu_B;
			4'b0001: result = alu_A - alu_B;
			4'b0010: begin   
				temp = alu_A;
				for (j = 0; j < alu_B[4:0]; j = j + 1) begin
					for (i = 31; i > 0; i = i - 1)
						temp[i] = temp[i-1];
					temp[0] = 1'b0;
				end
				result = temp;
			end
			4'b0011: begin   
				temp_slt = {1'b0, alu_A} - {1'b0, alu_B};
				overflow_slt = (alu_A[31] != alu_B[31]) && (temp_slt[31] != alu_A[31]);
				if ((temp_slt[31] ^ overflow_slt) == 1'b1) result = 1;
				else result = 0;
			end
			4'b0100: begin  
				temp_sltu = {1'b0, alu_A} - {1'b0, alu_B};
				if (temp_sltu[32] == 1'b1) result = 1;
				else result = 0;
			end
			4'b0101: result = alu_A ^ alu_B;
			4'b0110: begin   
				temp = alu_A;
				for (j = 0; j < alu_B[4:0]; j = j + 1) begin
					for (i = 1; i < 32; i = i + 1)
						temp[i-1] = temp[i];
					temp[31] = 1'b0;
				end
				result = temp;
			end
			4'b0111: begin   
				sign_bit = alu_A[31];
				temp = alu_A;
				for (j = 0; j < alu_B[4:0]; j = j + 1) begin
					for (i = 1; i < 32; i = i + 1)
						temp[i-1] = temp[i];
					temp[31] = sign_bit;
				end
				result = temp;
			end
			4'b1000: result = alu_A | alu_B;
			4'b1001: result = alu_A & alu_B;
			4'b1010: result = alu_B;   
			default: result = 32'd0;
		endcase
	end
endmodule
