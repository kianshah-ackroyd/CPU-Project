`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2025 17:00:43
// Design Name: 
// Module Name: register
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

module register_file(
    input logic     clk,
    input logic     reset,
    input logic     write_enable,
    input logic     [2:0] read_address1,
    input logic     [2:0] read_address2,
    input logic     [2:0] write_address,
    input logic     [7:0] write_data,
    output logic    [7:0] read_data1,
    output logic    [7:0] read_data2
    );
    logic [7:0] registers [0:7]; //array of 8 registers, //registers[0] = R0 ... registers[7] = R7, logic makes it 8 bits
    
    initial begin 
        for (int i = 0; i < 8; i++)
            registers[i] = 8'b0;
    end
        
    always_ff @(posedge clk) begin                          //for example, ADD R3, R1, R2,
        if (reset)
            for (int i = 0; i < 8; i++)
                registers[i] <= 8'b0;              
        else if(write_enable)                                   
            registers[write_address] <= write_data;         //writes_data to write address specified by always block
        end
    
    assign read_data1  = registers[read_address1];            //Read address 1 and 2, (R1 and R2) and values go to ALU
    assign read_data2  = registers[read_address2];            //Result comes back (write_data) to address R3 which gets written result (may store in a different register)
endmodule
