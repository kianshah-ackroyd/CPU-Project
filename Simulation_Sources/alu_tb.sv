`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.09.2025 09:14:51
// Design Name: 
// Module Name: alu_tb
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


module alu_tb();
    
    //internal signals
    logic [7:0] a;
    logic [7:0] b;
    logic [1:0] ctrl;
    logic [2:0] ctrl2;
    logic [7:0] y;
    logic [7:0] cout;
    logic [7:0] z;
    logic       overflow;
    logic       negative;
    //instantiate alu file
    alu uut (
        .a(a),
        .b(b),
        .ctrl(ctrl),
        .ctrl2(ctrl2),
        .y(y),
        .cout(cout),
        .z(z),
        .overflow(overflow),
        .negative(negative)
    );
    
    //start testbench
    initial begin
           $display("----ALU test started----");
           
       $display("Adder - Test 1\n"); 
           a =      8'h7;
           b =      8'h17;
           ctrl =   2'b00;
           ctrl2 =  3'b010;
           
           #5;
           
    // Debug outputs to see intermediate values
        $display("Inputs: a=%h, b=%h, ctrl=%b, ctrl2=%b", a, b, ctrl, ctrl2);
        $display("Expected: y=1E, Got: y=%h", y);
        $display("Cout=%h, z=%h, e = %h, f = %h, g = %h\n", cout, z, uut.e, uut.f, uut.g);
        
            #5;
            
       $display("Subtractor - Test 2\n"); 
           a =      8'b110101;
           b =      8'b100110;
           ctrl =   2'b01;
           ctrl2 =  3'b010;
           
           #5;
           
    // Debug outputs to see intermediate values
        $display("Inputs: a=%h, b=%h, ctrl=%b, ctrl2=%b", a, b, ctrl, ctrl2);
        $display("Expected: y=F, Got: y=%h", y);
        $display("Cout=%h, z=%h, e = %h, f = %h, g = %h\n", cout, z, uut.e, uut.f, uut.g);
        
            #5;
        
       $display("Carry-Out - Test 3\\n"); 
           a =      8'b11111111;
           b =      8'b11111111;
           ctrl =   2'b00;
           ctrl2 =  3'b010;
           
           #5;
           
    // Debug outputs to see intermediate values
        $display("Inputs: a=%h, b=%h, ctrl=%b, ctrl2=%b", a, b, ctrl, ctrl2);
        $display("Expected: y=1FE, Got: y=%h", y);
        $display("Cout=%h, z=%h, e = %h, f = %h, g = %h\n", cout, z, uut.e, uut.f, uut.g);
        
            #5;
        
        $display("Zero-Flag - Test 4\n"); 
           a =      8'b1000;
           b =      8'b1000;
           ctrl =   2'b01;
           ctrl2 =  3'b010;
           
           #5;
           
    // Debug outputs to see intermediate values
        $display("Inputs: a=%h, b=%h, ctrl=%b, ctrl2=%b", a, b, ctrl, ctrl2);
        $display("Expected: y=1FE, Got: y=%h", y);
        $display("Cout=%h, z=%h, e = %h, f = %h, g = %h\n", cout, z, uut.e, uut.f, uut.g);
        
            #5;
            
        $display("Overflow Test - Test 5\n"); 
           a =      8'b0111_1111;
           b =      8'b0000_0001;
           ctrl =   2'b00;
           ctrl2 =  3'b010;
           
           #5;
           
    // Debug outputs to see intermediate values
        $display("Inputs: a=%h, b=%h, ctrl=%b, ctrl2=%b", a, b, ctrl, ctrl2);
        $display("Expected: y=0x80, Got: y=%h", y);
        $display("Overflow = %h, negative = %h, Cout=%h, z=%h, e = %h, f = %h, g = %h\n", overflow, negative, cout, z, uut.e, uut.f, uut.g);  
        
        #5;
        
         $display("Negative Test - Test 5\n"); 
           a =      8'b0000_0000;
           b =      8'b0000_0001;
           ctrl =   2'b01;
           ctrl2 =  3'b010;
           
           #5;
           
    // Debug outputs to see intermediate values
          $display("Inputs: a=%h, b=%h, ctrl=%b, ctrl2=%b", a, b, ctrl, ctrl2);
          $display("Expected: y=0xFF, Got: y=%h", y);
          $display("Overflow = %h, negative = %h, Cout=%h, z=%h, e = %h, f = %h, g = %h\n",overflow, negative, cout, z, uut.e, uut.f, uut.g);
    end       
    
endmodule
