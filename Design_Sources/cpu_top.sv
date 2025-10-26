`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.10.2025 14:59:26
// Design Name: 
// Module Name: cpu_top
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


module cpu_top(
    input logic clk,
    input logic reset,
    input logic [15:0] switches,
    output logic [15:0] display_output,
    output logic   CA, CB, CC, CD, CE, CF, CG, DP,
    output logic   AN1, AN2, AN3, AN4
    
    );
    
    //program_counter internal logic
    logic [15:0]    display_converted_data;
    logic [7:0]     pc;
    logic [7:0]     starting_address;
    logic [12:0]    jump_address_from_ctrl; //13 bits from control unit
    logic [7:0]     load_address_to_pc; //8 bits to program counter
    logic           pc_load;
    
    //control unit internal logic 
    logic           reg_write_enable;
    logic           mem_write_enable;
    logic [2:0]     write_address;
    logic [9:0]     mem_address;
    logic [2:0]     read_address1;
    logic [2:0]     read_address2;
    logic [0:0]     alu_ctrl;
    logic [2:0]     alu_ctrl2;
    logic           negative_flag;
    
    //ALU Logic
    logic [7:0]     alu_cout;
    logic [7:0]     alu_result;
    logic [7:0]     alu_z;
    logic           overflow;
    
    //Register
    logic [7:0]     reg_write_data;
    logic [7:0]     reg_read_data1;
    logic [7:0]     reg_read_data2;
   
    //RAM
    logic [7:0]     mem_read_data;
    
    
    logic [15:0]    instruction;
    logic negative_flag_reg;
//negative flag register
    always_ff @(posedge clk) begin
        if (reset)
            negative_flag_reg <= 0;
        else
            negative_flag_reg <= negative_flag; //stores the negative flag so the BLT can use the stored value on its instruction
        end
        
    always_comb begin
        case(switches[15:14])
            2'b00: starting_address = 8'd0;  //addition
            2'b01: starting_address = 8'd5;  //subtraction
            2'b10: starting_address = 8'd10; //find max between 2 values
            2'b11: starting_address = 8'd10; //placeholder
        endcase
    end
    
    assign load_address_to_pc = jump_address_from_ctrl[7:0]; //jump address goes from 13 bits to 8 bits for pc
    
    logic is_load;
    assign is_load = (instruction[15:13] == 3'b100); //load opcode
    
    assign reg_write_data = is_load ? mem_read_data : alu_result; //if is load is 1, mem_read_data, 0, alu_result
    
    alu ALU(
        .a(reg_read_data1),
        .b(reg_read_data2),
        .ctrl(alu_ctrl),
        .ctrl2(alu_ctrl2),
        .cout(alu_cout),
        .y(alu_result),
        .z(alu_z),
        .negative(negative_flag),
        .overflow(overflow)
        );
        
    control_unit CTRL(
        .clk(clk),
        .reset(reset),
        .negative_flag(negative_flag_reg),
        .instruction(instruction),
        .alu_ctrl(alu_ctrl),
        .alu_ctrl2(alu_ctrl2),
        .reg_write_enable(reg_write_enable),
        .mem_write_enable(mem_write_enable),
        .write_address(write_address),
        .mem_address(mem_address),
        .read_address1(read_address1),
        .read_address2(read_address2),
        .jump_address(jump_address_from_ctrl),
        .pc_load(pc_load)
        );
        
    data_memory RAM(
        .clk(clk),
        .write_enable(mem_write_enable),
        .read_address(mem_address[7:0]),
        .write_address(mem_address[7:0]),
        .switches(switches[13:0]),
        .write_data(reg_read_data1), //STORE comes from register
        .read_data(mem_read_data),
        .display_output(display_output)
        );
    
    instruction_memory ROM(
        .instruction(instruction),
        .address(pc)
        );
        
    program_counter PC(
        .clk(clk),
        .reset(reset),
        .load(pc_load),
        .starting_address(starting_address),
        .load_address(load_address_to_pc),
        .pc(pc)
         );
    register_file REGISTER(
        .reset(reset),
        .clk(clk),
        .write_enable(reg_write_enable),
        .read_address1(read_address1),
        .read_address2(read_address2),
        .write_data(reg_write_data),
        .write_address(write_address),
        .read_data1(reg_read_data1),
        .read_data2(reg_read_data2)
        );
    seven_segment_display_subsystem SEVEN_SEGMENT_DISPLAY (
        .clk(clk), 
        .reset(reset), 
        .sec_dig1(display_converted_data[3:0]),     // Lowest digit
        .sec_dig2(display_converted_data[7:4]),     // Second digit
        .min_dig1(display_converted_data[11:8]),    // Third digit
        .min_dig2(display_converted_data[15:12]),   // Highest digit
        .decimal_point(decimal_pt),
        .CA(CA), .CB(CB), .CC(CC), .CD(CD), 
        .CE(CE), .CF(CF), .CG(CG), .DP(DP), 
        .AN1(AN1), .AN2(AN2), .AN3(AN3), .AN4(AN4)
    );
    bin_to_bcd BCD_CONVERTER (
	   .bin_in(display_output),
	   .bcd_out(display_converted_data),
	   .clk(clk),
	   .reset(reset)
	);
endmodule
