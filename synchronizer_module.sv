`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.10.2025 08:52:24
// Design Name: 
// Module Name: synchronizer_module
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


module synchronizer_module( //used to solve the issue of metastability because physical switches (asynchronous) are being connected directly to a synchronous system(floating between two values)
    input logic clk,
    input logic [15:0] switches_input,
    output logic [15:0] synchronized_output
    );
    
    logic [15:0] registers [0:1]; //array of 2 registers, each 16 bits, because there are 16 switches
    
    always_ff @(posedge clk) begin
          registers[0] <= switches_input; //synchronizer will catch an asynchronous input in the first register
          registers[1] <= registers[0];   //by the time the second clock edge arrives, the second register will store a stable value
    end
    
   assign synchronized_output = registers[1];
    
endmodule
