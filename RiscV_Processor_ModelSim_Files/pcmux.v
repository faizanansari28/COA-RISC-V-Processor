// 24I-6520 Mohammad Faizan Ansari - COA Project
module pcmux(input select,input is_jalr,input [31:0] pcaddby4_address, input [31:0] alu_result, output [31:0] current_address);
	assign current_address = select ? (is_jalr ? (alu_result & 32'hFFFFFFFE) : alu_result) : pcaddby4_address;
endmodule
