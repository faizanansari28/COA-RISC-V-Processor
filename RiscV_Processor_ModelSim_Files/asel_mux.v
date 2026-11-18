// 24I-6520 Mohammad Faizan Ansari - COA Project
// Asel/Bsel muxes (single-cycle design, no pipeline forwarding)
module asel_mux(input Asel, input [31:0] dataA, input [31:0] next_address, output [31:0] alu_A);
	assign alu_A = Asel ? next_address : dataA;
endmodule
