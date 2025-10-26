`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.09.2025 17:02:29
// Design Name: 
// Module Name: alu_design
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

//module for the top mux of the adder (inversion of b and b)
module mux_1
    #(parameter width_1 = 8)
     (input logic       [width_1 - 1: 0] b,
      input logic       [0:0]          ctrl,
      output logic      [width_1 - 1: 0] y);
      
      assign y = ctrl ? ~b : b; //if ctrl = 1, invert b, if ctrl = 0, leave b as positive
      
endmodule     
//module for mux at bottom of alu, responsible for deciding whether to use addition/subtraction, AND or OR     
module mux_2
     #(parameter width_2 = 8)
      (input logic      [width_2 - 1: 0] e,
       input logic      [width_2 - 1: 0] f,
       input logic      [width_2 - 1: 0] g,
       input logic      [2:0]            ctrl2,
       output logic     [width_2 - 1: 0] y);
       
       assign y = (ctrl2 == 3'b000) ? g:
                  (ctrl2 == 3'b001) ? f:    //if the code is above 010, it the answer will be defaulted to 0, however, these excess codes can be used for more operations.
                  (ctrl2 == 3'b010) ? e:
                  8'b0;
endmodule   
//main alu module that will contain the adder, and put all the Mux's together.
module alu (input logic     [7:0] a,
            input logic     [1:0] ctrl,
            input logic     [2:0] ctrl2,
            input logic     [7:0] b,
            output logic    [7:0] y, cout,
            output logic    [7:0] z);
            
        //pos is positive b, neg is negative b, e is adder output, f is OR output, and g is AND output    
        logic  [7:0] final_b, e, f, g;
        
        mux_1 #(8) bmux(b, ctrl[0], final_b); //ctrl[0] is the 1st control bit so if it's 1, final_b is negative and if it's 0, final b is positive
        
        always_comb begin
        f = a | final_b;
        g = a & final_b;
        end
        
        assign {cout, e} = a + final_b + ctrl[0];
        
        mux_2 #(8) final_output (g, f, e, ctrl2, y);
        
        assign z = {7'b0, ~|y}; //zero flag, so if y are all zero's, it will OR with the bits and the zero flag will set off

endmodule                
