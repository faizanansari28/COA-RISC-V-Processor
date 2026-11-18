// 24I-6520 Mohammad Faizan Ansari - COA Project
module instruction_memory(input [31:0] address, output [31:0] instruction);
	reg [31:0] memory [0:1023];
	integer i;
	initial begin
		for (i = 0; i < 1024; i = i + 1)
			memory[i] = 32'h13;               
		$readmemh("memory_initializing.txt", memory);     
	end
	assign instruction = memory[address/4];
endmodule
