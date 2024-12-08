# CPU Architecture Details

## Overview
This project implements a custom **19-bit CPU** designed to provide efficient processing for both simple and specialized tasks. The CPU is based on a **Harvard architecture**, which means it has separate data and instruction memory. This allows it to fetch instructions and data in parallel, improving performance.

### Key Features:
- **19-bit Instruction Width**: The instruction word is 19 bits wide to accommodate custom operations with sufficient precision.
- **8 General-purpose Registers**: These registers are used for storing data and intermediate results during computation.
- **Arithmetic and Logical Unit (ALU)**: Supports basic arithmetic operations (addition, subtraction, multiplication), bitwise logical operations (AND, OR), and shift operations (SHL, SHR).
- **Memory Interface**: Provides a mechanism to load data from and store data to memory.
- **Pipeline Stages**: The CPU implements a simplified pipeline with **fetch**, **decode**, and **execute** stages, improving the throughput of instruction processing.

---

## Components

### 1. **Instruction Fetch**
The instruction fetch unit retrieves instructions from memory based on the **program counter (PC)**, which keeps track of the current instruction location. The instruction is then decoded to identify the operation and operands.

### 2. **Control Unit**
The control unit decodes the instruction and generates the necessary control signals for the ALU, register file, and memory. It manages the pipeline by ensuring that operations happen in the correct sequence.

### 3. **Register File**
The register file contains **8 general-purpose registers**, each 19 bits wide. These registers are used to store data during computation and are directly accessible by the ALU.

### 4. **ALU (Arithmetic and Logical Unit)**
The ALU is responsible for performing arithmetic and logical operations. It can handle operations such as:
- **Arithmetic Operations**: Addition, subtraction, and multiplication.
- **Logical Operations**: Bitwise AND, OR, XOR, and NOT.
- **Shift Operations**: Left shift (SHL) and right shift (SHR).

### 5. **Memory Interface**
The CPU interacts with memory for both reading and writing data. The **LD** (load) instruction retrieves data from memory into a register, while the **ST** (store) instruction writes data from a register into memory.


---

## Instruction Set and Operation

The CPU uses a custom 19-bit instruction format with a 5-bit opcode and 14 bits for operands:
- **Opcode** (5 bits): Defines the operation (e.g., ADD, AND, LD).
- **Registers** (3 bits each): Defines the source and destination registers for operands.
- **Immediate** (8 bits): Some operations, like shift, use an immediate value.

### Example Operation

**ADD Instruction**:
- **Opcode**: `00000`
- **Operation**: `ADD`
- **Operands**: Register 1 (`R1`) = Register 2 (`R2`) + Register 3 (`R3`)
- **Result**: The result of the addition is stored in `R1`.

---

## Pipeline

The CPU implements a **simple 3-stage pipeline**:
1. **Instruction Fetch**: The instruction is fetched from memory.
2. **Instruction Decode**: The instruction is decoded to identify the operation and operands.
3. **Execute**: The operation is executed (e.g., arithmetic, logical, memory operation).

---
