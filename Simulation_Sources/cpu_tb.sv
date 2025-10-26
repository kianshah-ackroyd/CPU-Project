`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.10.2025 09:57:26
// Design Name: 
// Module Name: cpu_tb
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


module cpu_tb();

    logic clk;
    logic reset;
    logic [15:0] switches;
    logic [7:0] display_output;

    // === DUT Instantiation ===
    cpu_top dut (
        .clk(clk),
        .reset(reset),
        .switches(switches),
        .display_output(display_output)
    );

    // === Clock Generation (10 ns period → 100 MHz) ===
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // === Initialize Inputs & Apply Reset ===
    initial begin
        // Initialize everything BEFORE simulation starts
        switches = 16'b11_0000011_0000111;  // program 00, A=7, B=3
        reset    = 1;                       // hold reset high initially
        #12;                                // wait half a clock cycle
        @(posedge clk);                     // ensure at least one clock while reset=1
        reset    = 0;                       // release reset cleanly
    end

    // === Monitor / Display ===
    initial begin
        $display("=== CPU Test Started ===");

        // Wait until reset deasserted
        @(negedge reset);
        $display("Reset released at time %0t", $time);

        // Observe CPU for several cycles
        repeat (20) begin
            @(posedge clk);
            $display("Time=%0t | PC=%0d | instr=%h | reg1=%h | reg2=%h | ALU=%h | negative flag=%h | overflow=%h | disp=%h",
                     $time,
                     dut.PC.pc,                 // direct access into program_counter instance
                     dut.instruction,
                     dut.reg_read_data1,
                     dut.reg_read_data2,
                     dut.alu_result,
                     dut.negative_flag,
                     dut.overflow,
                     display_output);
        end

        $display("\n=== Expected: Display ≈ 7 ===");
        $display("Actual Display Output: %d", display_output);

        $finish;
    end

endmodule
