# 8 Bit cpu on FPGA

## Project Overview
This is a fully functional 8-bit CPU designed and implemented on a Basys3 FPGA board. The project is currently being developed alongside the 2025-2026 academic year, applying concepts from Computer Architecture and SystemVerilog coursework.

## Features
Custom 8-Bit CPU architecture with a complete datapath and control unit
- 8 Instructions including:
    - Arithmetic: ADD, SUB (planning to add MULT and DIV into my ALU)
    - Logic: AND, OR
    - Mem: LOAD, STORE
    - Control flow: JUMP, BLT (Branch if less than)
- 4 executable programs:
    - Binary Addition
    - Binary Subtraction
    - Finding the Max of 2 Values
    - Placeholder for a future program
- Hardware Input/Outputs
    - Switch-based input for program selection and operation inputs
    - Output displays (7-segment and LED hex)
    
## Architecture
- ALU - Performs arithmetic and logic operations (inspiration from ALU design came from my computer architecture class)
- Register File - Contains 8 general-purpose 8 bit registers
- Control Unit - Contains an instruction decoder for all 8 instructions using opcodes
- Program Counter - Supports sequential execution of programs allowing for the accomodation of jumps/branches
- Instruction Memory(ROM) - Contains program instructions
- Data Memory (RAM) - internal memory (storage) mapped directly to outputs for switches and displays

## How to Use
1) Select Program with Switches[15:14]
    - 00 Addition
    - 01 Subtraction
    - 10 Find Max Value
    - 11 (Placeholder so also finds the max value)
2) Set inputs(hex input)
    - Switches [13:7] - First Input
    - Switches [6:0]  - Second Input
3) Run Code
    - Press center reset button
4) View Results
    - 7 Segment Display Showing the Decimal Result
    - LED's showing the hex result

## Hardware Requirements
- Basys3 Artix-7 FPGA Board
- Xilinx Vivado Design Suite 2025.1 (or compatable version)
- Language: System Verilog

## Acknowledgments
The following files were provided by my instructor (Denis Onen) for lab assignments and were adapted for this project
- personal_bin_to_bcd.sv
- personal_digit_multiplexor.sv
- personal_seven_segment_decoder.sv
- personal_seven_segment_digit_selector.sv
- personal_seven_segment_display_subsystem.sv
- Basys_3_Project.xdc

## License
This project is part of my personal portfolio. Feel free to reference it for learning opportunities, but please don't copy the contents for academic submissions











