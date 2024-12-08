`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:00:45 12/05/2024
// Design Name:   cpu
// Module Name:   E:/vicharak/vicharakFPGA/cpu_tb.v
// Project Name:  vicharakFPGA
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cpu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ps

module cpu_tb;

    // Testbench Signals
    reg clk;             // Clock signal
    reg rst_n;           // Reset signal (active low)
    wire [18:0] pc;      // Program Counter
    wire [18:0] address; // Memory address output
    wire mem_read;       // Memory read signal
    wire mem_write;      // Memory write signal
    reg [18:0] data_bus_reg; // Register to drive inout data bus
    wire [18:0] data_bus;    // Data bus (inout)

    // Bidirectional data bus control
    assign data_bus = mem_write ? data_bus_reg : 19'bz;

    // Instantiate the CPU module
    cpu uut (
        .clk(clk),
        .rst_n(rst_n),
        .pc(pc),
        .data_bus(data_bus),
        .address(address),
        .mem_read(mem_read),
        .mem_write(mem_write)
    );

    // Clock Generation: 10 ns period (100 MHz)
    always begin
        #5 clk = ~clk;
    end

    // Testbench Initialization and Simulation
    initial begin
        // Initialize inputs
        clk = 0;
        rst_n = 0;       // Assert reset
        data_bus_reg = 19'b0; // Clear data bus

        // Apply reset
        #15 rst_n = 1; // De-assert reset after 15 ns

        // Wait for a few clock cycles for initial operations
        repeat (5) @(posedge clk);

        // Test 1: Arithmetic operation (ADD)
        // Instruction: ADD R1 = R2 + R3 (opcode = 00000)
        uut.register_file[2] = 19'd10; // R2 = 10
        uut.register_file[3] = 19'd5;  // R3 = 5
        uut.ir = {5'b00000, 3'd1, 3'd2, 3'd3}; // ADD R1 = R2 + R3

        @(posedge clk); // Execute
        #5; // Wait for operation to complete
        $display("Test 1 - ADD Result: %d (Expected: 15)", uut.register_file[1]);

        // Test 2: Logical operation (AND)
        uut.register_file[2] = 19'b1010; // R2 = 1010
        uut.register_file[3] = 19'b1100; // R3 = 1100
        uut.ir = {5'b00010, 3'd1, 3'd2, 3'd3}; // AND R1 = R2 & R3

        @(posedge clk); // Execute
        #5;
        $display("Test 2 - AND Result: %b (Expected: 1000)", uut.register_file[1]);

        // Test 3: Load (LD) operation
        uut.ir = {5'b01100, 3'b000, 8'd0}; // Load from address 0
        data_bus_reg = 19'd42; // Simulated memory content at address 0
        @(posedge clk); // Execute
        #5;
        $display("Test 3 - LD Data: %d (Expected: 42)", uut.register_file[0]);

        // Test 4: Store (ST) operation
        uut.register_file[1] = 19'd99; // R1 = 99
        uut.ir = {5'b01101, 3'd1, 8'd0}; // Store R1 to address 0
        @(posedge clk); // Execute
        #5;
        $display("Test 4 - ST Data: %d (Expected: 99)", data_bus_reg);

        // Final checks and simulation end
        #20;
        $stop;
    end
endmodule
