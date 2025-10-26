`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.10.2025 14:00:38
// Design Name: 
// Module Name: data_memory
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


module data_memory(
    input logic     write_enable,
    input logic     clk,
    input logic     [7:0] read_address,
    input logic     [7:0] write_address,
    input logic     [13:0] switches,
    input logic     [7:0] write_data,
    output logic    [7:0] read_data,
    output logic    [7:0] display_output
    );
    
    logic [7:0] ram [0:255];
    
    initial begin
        for(int i = 0; i < 256; i++)
            ram[i] = 8'b0;
    end
    
    always_comb begin
        if (read_address == 8'd0) //data memory address 0, input 1
            read_data = {1'b0, switches[13:7]}; //switches input 13 - 7
        else if (read_address == 8'd1) //data memory address 1, input 2
            read_data = {1'b0, switches[6:0]}; //switches input 6-0
        else
            read_data = ram[read_address]; //the read data will take from the ram address if a read adress is not 0 or 1
    end
        
    always_ff @(posedge clk) begin
        if (write_enable) begin
           if (write_address == 8'd100) 
                display_output <= write_data; //output to display
           else
               ram[write_address] <= write_data; //incase the write address is different, it will write to RAM and not display on the output
        end
    end
endmodule
