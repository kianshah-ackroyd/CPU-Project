`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2025 21:19:39
// Design Name: 
// Module Name: instruction_memory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// for ALU operations (AND, OR, ADD, SUB) follows the format 
//[opcode (15:13)][dest(12:10)][src1(9:7)][src2(6:4)][unused 4 bits(3:0)]
// for LOAD, STORE
//[opcode (15:13)][register(12:10)][10-bit address {9:0)]
// for JUMP/BLT (branch less than)
//[opcode (15:13)][target address (12:0)]
//OPCODE INSTRUCTIONS:
//000: AND
//001: OR
//010: ADD
//011: SUB
//100: LOAD
//101: STORE
//110: JUMP
//111: BLT (branch if less than)
module instruction_memory(
    input logic     [7:0] address,
    output logic    [15:0] instruction
    );
    //declaring ROM (instruction memory) array
    logic [15:0] rom [0:255]; //255 location with 16 bits each
    
    initial begin
          //ADD instruction begin
          rom[0] =  16'b100_001_0000000000; //load R1, [0]
          rom[1] =  16'b100_010_0000000001; //load R2, [1]
          rom[2] =  16'b010_011_001_010_0000; //ADD R3, R1, R2 (unused 4 bits at end)
          rom[3] =  16'b101_011_0001100100; //store R3 in memory address 100
          rom[4] =  16'b110_0000000000100; //jumps to itself halting the program when the addition instruction finishes
          //ADD instruction finished
          //SUB instruction begin
          rom[5] =  16'b100_001_0000000000; //Load R1, [0]
          rom[6] =  16'b100_010_0000000001; //Load R2, [1]
          rom[7] =  16'b011_011_001_010_0000; //SUB R3, R1, R2 (unused 4 bits at the end)
          rom[8] =  16'b101_011_0001100100; //store R3 in memory address 100
          rom[9] =  16'b110_0000000001001; //jumps to itself halting the program when the subtration instruction finishes
          //SUB instruction finished
          //Find max between two values begin
          rom[10] =  16'b100_001_0000000000; //Load R1, [0]
          rom[11] =  16'b100_010_0000000001; //Load R2, [1]
          rom[12] = 16'b011_011_001_010_0000; //SUB R3, R1, R2 (unused 4 bits at the end)
          rom[13] = 16'b111_0000000010000; //BLT (branch if R1 is less than R2 to instruction number 16)
          rom[14] = 16'b101_001_0001100100; //store R1 in memory addres 100 if R1 is greater than R2
          rom[15] = 16'b110_0000000001111; //jumps to itself creating an endless loop and halting the program
          rom[16] = 16'b101_010_0001100100; //stores R2 in memory addres 100 if R2 is greater than R1 (BLT jumps to this line)
          rom[17] = 16'b110_0000000010001; //jumps to itself haltin the program when the finding max between two values program finishes
          
          
    end
    
    assign instruction = rom[address];
endmodule
