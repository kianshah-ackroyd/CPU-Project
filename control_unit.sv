`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.10.2025 14:29:19
// Design Name: 
// Module Name: control_unit
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


module control_unit(
    input logic     clk,
    input logic     reset,
    input logic     negative_flag,
    input logic     [15:0] instruction, //16 bits from instruction memory
    output logic    [0:0] alu_ctrl, //goes to ALU
    output logic    [2:0] alu_ctrl2,  //goes to ALU
    output logic    reg_write_enable,  //goes to register file
    output logic    mem_write_enable,  //writes to memory as opposed to a register
    output logic    [2:0] write_address,
    output logic    [9:0] mem_address,
    output logic    [2:0] read_address1,
    output logic    [2:0] read_address2,
    output logic    [12:0] jump_address,
    output logic    pc_load
    );
    
    logic [2:0]     opcode;
    assign opcode = instruction [15:13];
    
    always_comb begin
            //assigning default values
            reg_write_enable = 1'b0;
            mem_write_enable = 1'b0;
            pc_load = 1'b0;
            alu_ctrl = 1'b0;
            alu_ctrl2 = 3'b000;
            write_address = 3'b000;
            read_address1 = 3'b000;
            read_address2 = 3'b000;
            mem_address = 10'b0;
            jump_address = 13'b0;
        case(opcode)
            3'b000: begin //AND
              reg_write_enable  = 1'b1;
              write_address     = instruction[12:10];
              read_address1     = instruction[9:7];
              read_address2     = instruction[6:4];
              alu_ctrl          = 1'b0;
              alu_ctrl2         = 3'b000;
            end
            3'b001: begin //OR
              reg_write_enable  = 1'b1;
              write_address     = instruction[12:10];
              read_address1     = instruction[9:7];
              read_address2     = instruction[6:4];
              alu_ctrl          = 1'b0;
              alu_ctrl2         = 3'b001;
            end
            3'b010: begin //ADD
              reg_write_enable  = 1'b1;
              write_address     = instruction[12:10];
              read_address1     = instruction[9:7];
              read_address2     = instruction[6:4];
              alu_ctrl          = 1'b0;
              alu_ctrl2         = 3'b010;
            end
            3'b011: begin //SUB
              reg_write_enable  = 1'b1;
              write_address     = instruction[12:10];
              read_address1     = instruction[9:7];
              read_address2     = instruction[6:4];
              alu_ctrl          = 1'b1;
              alu_ctrl2         = 3'b010;
            end
            3'b100: begin //LOAD
              reg_write_enable  = 1'b1;
              mem_write_enable  = 1'b0;
              write_address     = instruction[12:10];
              mem_address       = instruction[9:0];
            end
            3'b101: begin //STORE
              reg_write_enable  = 1'b0;
              mem_write_enable  = 1'b1;
              read_address1   = instruction[12:10];
              mem_address     = instruction[9:0];
            end
            3'b110: begin //JUMP
              pc_load = 1'b1; //controls if the program counter jumps
              jump_address = instruction[12:0];
            end
            3'b111: begin //BLT
              jump_address = instruction[12:0];
              if (negative_flag)
                  pc_load = 1'b1; //controls if the program counter jumps
             end
        endcase   
    end      
          
         
    
endmodule
