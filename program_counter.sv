`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2025 20:59:01
// Design Name: 
// Module Name: program_counter
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


module program_counter(
    input logic     clk,
    input logic     reset,
    input logic     load,              // For jumps/branches
    input logic     [7:0] starting_address,
    input logic     [7:0] load_address,   // Address to jump to
    output logic    [7:0] pc          // Current PC value
);

initial begin
        pc = 8'b0;
end

always_ff @(posedge clk or posedge reset) begin
    if (reset)
        pc <= starting_address; //pc starts at the starting address (start of the program)
    else if (load)              //if there is a load in the code (jump or branch if less than (blt)) it will jump to that address
        pc <= load_address;
    else
        pc <= pc + 1;           //otherwise, the pc will incrimentally increase by 1 going through the instructions
    end
    
endmodule
