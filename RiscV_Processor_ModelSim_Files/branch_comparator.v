// 24I-6520 Mohammad Faizan Ansari - COA Project
module branch_comparator(input [31:0] dataA, input [31:0] dataB, input BrUn, output breq, output brlt);
	wire [32:0] diff = {1'b0, dataA} - {1'b0, dataB};
	wire overflow = (dataA[31] != dataB[31]) && (diff[31] != dataA[31]);
	assign breq = (diff[31:0] == 32'd0) ? 1 : 0;
	assign brlt = BrUn ? diff[32] : (diff[31] ^ overflow);
endmodule
