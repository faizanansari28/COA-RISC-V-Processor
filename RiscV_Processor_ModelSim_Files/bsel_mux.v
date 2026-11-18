// 24I-6520 Mohammad Faizan Ansari - COA Project
module bsel_mux(input Bsel, input [31:0] dataB, input [31:0] immediate, output [31:0] alu_B);
	assign alu_B = Bsel ? immediate : dataB;
endmodule
