// 24I-6520 Mohammad Faizan Ansari - COA Project
module wb_mux(input [31:0] pc,input [31:0] alu_result, input [31:0]data_read,input [1:0] wb_selection, output reg [31:0] wb);
	always @(*) begin
		case(wb_selection)
			2'b00: wb = data_read;
			2'b01: wb = alu_result;
			2'b10: wb = pc;
			default:	wb=32'd0;
		endcase
	end
endmodule
