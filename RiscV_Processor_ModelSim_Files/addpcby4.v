// 24I-6520 Mohammad Faizan Ansari - COA Project
module addpcby4(input [31:0] address, output [31:0] pcaddby4_address);
	assign pcaddby4_address = address + 32'd4;
endmodule
