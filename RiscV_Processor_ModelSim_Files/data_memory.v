// 24I-6520 Mohammad Faizan Ansari - COA Project
module data_memory(input [31:0] alu_result, input [31:0] data_B, input clk, input memory_register_write, input [2:0] function3, output reg [31:0] data_read);
	reg [31:0] memory [0:1023];                                
	wire [31:0] temp = memory[alu_result/4];
	wire [1:0] off = alu_result[1:0];                            
	wire [31:0] shifted = temp >> {off, 3'b000};                 
	integer i;
	initial begin
		for (i = 0; i < 1024; i = i + 1)                         
			memory[i] = 32'd0;
	end
	always @(posedge clk) begin
		if (memory_register_write == 1) begin
			case (function3)
				3'b000: begin                                    
					case (off)
						2'b00: memory[alu_result/4] <= {temp[31:8],  data_B[7:0]};
						2'b01: memory[alu_result/4] <= {temp[31:16], data_B[7:0], temp[7:0]};
						2'b10: memory[alu_result/4] <= {temp[31:24], data_B[7:0], temp[15:0]};
						2'b11: memory[alu_result/4] <= {data_B[7:0], temp[23:0]};
					endcase
				end
				3'b001: begin                                   
					if (off[1]) 
						memory[alu_result/4] <= {data_B[15:0], temp[15:0]};
					else        
						memory[alu_result/4] <= {temp[31:16], data_B[15:0]};
				end
				3'b010: memory[alu_result/4] <= data_B;          
			endcase
		end
	end
	always @(*) begin                                           
		case (function3)
			3'b000: data_read = {{24{temp[7]}},  temp[7:0]};
			3'b001: data_read = {{16{temp[15]}}, temp[15:0]};
			3'b010: data_read = temp;
			3'b100: data_read = {24'd0, temp[7:0]};
			3'b101: data_read = {16'd0, temp[15:0]};
			default: data_read = 32'd0;
		endcase
	end
endmodule
