# RISC-V Processor Implementation

## Computer Organization and Architecture (COA) Project

## Project Overview

This project focuses on the implementation of a RISC-V processor using Verilog HDL as part of the Computer Organization and Architecture course at FAST-NUCES Islamabad.

The processor is designed to demonstrate the fundamental concepts of computer architecture, including instruction fetching, decoding, execution, memory operations, and write-back.

The project is implemented and simulated using ModelSim, while Logisim is used for graphical circuit design and visualization.

## Technologies Used

- Verilog HDL
- ModelSim
- Logisim

## Project Features

- Implementation of individual processor components using Verilog.
- Program Counter for instruction address management.
- Instruction Memory for storing and fetching instructions.
- Control Unit for generating processor control signals.
- Register File for storing and accessing register values.
- Immediate Generator for extracting immediate values.
- Arithmetic Logic Unit (ALU) for arithmetic and logical operations.
- Branch Comparator for conditional branching.
- Data Memory for load and store operations.
- Write-Back Unit for updating register values.
- Processor simulation and waveform analysis using ModelSim.
- Graphical processor implementation using Logisim.

## Processor Components

The processor consists of multiple interconnected modules that work together to execute instructions.

Each component is implemented separately using Verilog HDL to maintain modularity and simplify testing and debugging.

The Program Counter manages instruction addresses, while the Instruction Memory provides instructions to the processor. The Control Unit generates the necessary control signals, and the Register File supplies operands for execution.

The ALU performs arithmetic and logical operations, while the Immediate Generator extracts immediate values from instructions. The Branch Comparator handles conditional comparisons, and the Data Memory manages memory operations.

Finally, the Write-Back Unit selects the appropriate result to update the destination register.

## ALU Operations

The Arithmetic Logic Unit supports the following operations:

- ADD
- SUB
- AND
- OR
- XOR
- SLT
- SLTU
- SLL
- SRL
- SRA

## Simulation

ModelSim is used to compile, simulate, and verify the Verilog modules.

The simulation environment allows observation of internal processor signals, register values, control signals, memory operations, and ALU results through waveform analysis.

## Logisim Implementation

The project also includes a Logisim circuit file representing the processor implementation.

It provides a graphical view of the processor architecture and the connections between its major components.

## Repository Contents

This repository contains the Verilog source files, Logisim circuit file, and required memory initialization files used in the processor implementation.

## Author

**Mohammad Faizan Ansari**

Computer Engineering  
FAST-NUCES Islamabad

Roll Number: 24I-6520

## Acknowledgment

This project was developed as part of the Computer Organization and Architecture course to gain practical experience in processor design, Verilog programming, digital logic, and computer architecture.

