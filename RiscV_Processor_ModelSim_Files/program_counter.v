// 24I-6520 Mohammad Faizan Ansari - COA Project
module program_counter(input clk, input clr, input [31:0] current_address, output reg [31:0] next_address);
	always @(posedge clk or posedge clr) begin
		if (clr) next_address <= 32'd0;
		else     next_address <= current_address;
	end
endmodule
