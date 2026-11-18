// 24I-6520 Mohammad Faizan Ansari - COA Project
module tb;
    reg clk;
    reg clr;

    // PC signals
    wire [31:0] pc;
    wire [31:0] pc_plus4;
    wire [31:0] next_pc;

    // Instruction signals
    wire [31:0] instruction;

    // Register File signals
    wire [31:0] dataA;
    wire [31:0] dataB;
    wire [31:0] write_back;

    // Immediate Generator
    wire [31:0] immediate;

    // Control Unit signals
    wire PC_Sel;
    wire [2:0] Imm_Sel;
    wire RegWen;
    wire BrUn;
    wire Asel;
    wire Bsel;
    wire [3:0] Alu_select;
    wire Mem_RW;
    wire [1:0] WB_sel;
    wire is_jalr;

    // ALU signals
    wire [31:0] alu_A;
    wire [31:0] alu_B;
    wire [31:0] alu_result;

    // Branch Comparator
    wire BrEq;
    wire BrLT;

    // Data Memory
    wire [31:0] data_read;

    // PROCESSOR CONNECTIONS

    program_counter PC_UNIT(.clk(clk),.clr(clr),.current_address(next_pc),.next_address(pc));
    addpcby4 PC_ADD(.address(pc),.pcaddby4_address(pc_plus4));
    instruction_memory IMEM(.address(pc),.instruction(instruction));
    register_file RF(.instruction(instruction),.register_write_selection(RegWen),.clk(clk),.write_back(write_back),.dataA(dataA),.dataB(dataB));
    immediate_generator IMM(.instruction(instruction),.Immediate_Select(Imm_Sel),.immediate(immediate));
    branch_comparator BC(.dataA(dataA),.dataB(dataB),.BrUn(BrUn),.breq(BrEq),.brlt(BrLT));
    asel_mux A_MUX(.Asel(Asel),.dataA(dataA),.next_address(pc),.alu_A(alu_A));
    bsel_mux B_MUX(.Bsel(Bsel),.dataB(dataB),.immediate(immediate),.alu_B(alu_B));
    ALU ALU_UNIT(.alu_A(alu_A),.alu_B(alu_B),.ALU_select(Alu_select),.result(alu_result));
    data_memory DMEM(.alu_result(alu_result),.data_B(dataB),.clk(clk),.memory_register_write(Mem_RW),.function3(instruction[14:12]),.data_read(data_read));
    wb_mux WB(.pc(pc_plus4),.alu_result(alu_result),.data_read(data_read),.wb_selection(WB_sel),.wb(write_back));
    control_unit CU(.instruction(instruction),.BrEq(BrEq),.BrLT(BrLT),.PC_Sel(PC_Sel),.Imm_Sel(Imm_Sel),.RegWen(RegWen),.BrUn(BrUn),.Asel(Asel),.Bsel(Bsel),.Alu_select(Alu_select),.Mem_RW(Mem_RW),.WB_sel(WB_sel),.is_jalr(is_jalr));
    pcmux PC_MUX(.select(PC_Sel),.is_jalr(is_jalr),.pcaddby4_address(pc_plus4),.alu_result(alu_result),.current_address(next_pc));

    // CLOCK GENERATION

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // TEST PROGRAM
    initial begin
        clr = 1;

        #1;
        IMEM.memory[0] = 32'h00A00093; // addi x1,x0,10
        IMEM.memory[1] = 32'h01400113; // addi x2,x0,20
        IMEM.memory[2] = 32'h002081B3; // add x3,x1,x2
        IMEM.memory[3] = 32'h00302023; // sw x3,0(x0)
        IMEM.memory[4] = 32'h00002203; // lw x4,0(x0)
        IMEM.memory[5] = 32'h00418463; // beq x3,x4,8
        IMEM.memory[6] = 32'h00100293; // addi x5,x0,1
        IMEM.memory[7] = 32'h0080036F; // jal x6,8
        IMEM.memory[8] = 32'h00000013; // nop
        IMEM.memory[9] = 32'h0000006F; // jal x0,0

        #19;
        clr = 0;
    end

endmodule
