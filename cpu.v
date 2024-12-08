`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:28:18 12/04/2024 
// Design Name: 
// Module Name:    cpu 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module cpu (
    input wire clk,               // Clock signal
    input wire rst_n,             // Active low reset signal
    output reg [18:0] pc,         // Program Counter
    input wire [18:0] data_in,    // Data input (from memory)
    output wire [18:0] data_out,  // Data output (to memory)
    output reg [18:0] address,    // Address bus for memory access
    output reg mem_read,          // Memory read signal
    output reg mem_write          // Memory write signal
);

    // Register File: 8 general-purpose 19-bit registers
    reg [18:0] register_file [0:7];  
    reg [18:0] ir;        // Instruction Register
    reg [18:0] alu_out;   // ALU Output Register

    // ALU Inputs and Result
    reg [18:0] alu_a, alu_b;
    reg [18:0] alu_result;

    // Simple instruction memory for testing (if external memory is not used)
    reg [18:0] memory [0:255];

    // ALU Operation
    always @(*) begin
        case (ir[18:14]) // Opcode determines ALU operation
            5'b00000: alu_result = alu_a + alu_b;        // ADD
            5'b00001: alu_result = alu_a - alu_b;        // SUB
            5'b00010: alu_result = alu_a & alu_b;        // AND
            5'b00011: alu_result = alu_a | alu_b;        // OR
            5'b00100: alu_result = alu_a << ir[7:0];     // SHL (Shift Left)
            5'b00101: alu_result = alu_a >> ir[7:0];     // SHR (Shift Right)
            5'b01000: alu_result = alu_a * alu_b;        // MUL
            5'b01001: alu_result = alu_a ^ alu_b;        // XOR
            5'b01110: alu_result = ~alu_a;               // NOT
            default: alu_result = 19'b0;                 // Default
        endcase
    end

    // Fetch-Decode-Execute Cycle
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pc <= 19'b0;  // Reset Program Counter
        end else begin
            // Instruction Fetch
            ir <= memory[pc];

            // Decode Stage
            alu_a <= register_file[ir[13:11]];  // First source operand
            if (ir[18:14] < 5'b01100)  // For arithmetic instructions
                alu_b <= register_file[ir[10:8]];
            else
                alu_b <= {11'b0, ir[7:0]};  // Immediate value (sign-extended)

            // Execute Stage
            alu_out <= alu_result;

            // Write Back
            if (ir[18:14] < 5'b01100)  // Arithmetic and logical instructions
                register_file[ir[7:5]] <= alu_out;

            // Update Program Counter
            pc <= pc + 1;
        end
    end

    // Memory Interface: For Load and Store Instructions
    always @(posedge clk) begin
        case (ir[18:14])
            5'b01100: begin  // LD (Load)
                mem_read <= 1;
                mem_write <= 0;
                address <= alu_out;
                register_file[ir[7:5]] <= data_in;
            end
            5'b01101: begin  // ST (Store)
                mem_read <= 0;
                mem_write <= 1;
                address <= alu_out;
            end
            default: begin
                mem_read <= 0;
                mem_write <= 0;
            end
        endcase
    end

    // Data Bus Output
    assign data_out = (mem_write) ? register_file[ir[7:5]] : 19'bz;

endmodule

