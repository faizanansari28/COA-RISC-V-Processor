// 24I-6520 Mohammad Faizan Ansari - COA Project
module register_file(input [31:0] instruction, input register_write_selection, input clk, input [31:0] write_back, output [31:0] dataA, output [31:0] dataB);
	reg [31:0] registers [0:31];
	wire [4:0] rs1 = instruction[19:15];
	wire [4:0] rs2 = instruction[24:20];
	wire [4:0] rd  = instruction[11:7];
	integer i;
	initial begin
		for (i = 0; i < 32; i = i + 1)
			registers[i] = 32'd0;
	end
	assign dataA = (rs1 == 0) ? 32'd0 : registers[rs1];
	assign dataB = (rs2 == 0) ? 32'd0 : registers[rs2];
	always @(posedge clk) begin
		if (register_write_selection && rd != 0)
			registers[rd] <= write_back;
	end
endmodule
