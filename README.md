# vicharakfpga
# 19-Bit Custom CPU Design

This repository contains the Verilog implementation of a custom 19-bit CPU, designed to support a specialized instruction set for specific applications like signal processing and cryptography. The project consists of a CPU module and its corresponding testbench for validation.

---

## **Overview**

The CPU architecture features:
- A **19-bit instruction size** tailored for efficient computation.
- **8 general-purpose registers** to store operands and results.
- **Custom ALU operations** supporting arithmetic, logical, and shift operations.
- **Memory read/write interface** for load and store instructions.
- A simple **instruction pipeline** implementing the fetch-decode-execute cycle.

---

## **Repository Structure**

- `src/cpu.v`: The main Verilog module implementing the 19-bit CPU architecture.
- `src/cpu_tb.v`: The testbench for validating the CPU's functionality.
- `docs/instruction_set.md`: A detailed explanation of the custom instruction set.
- `docs/architecture_spec.md`: Comprehensive architectural specification of the CPU.

---

## **Architecture Specification**

### Key Features:
1. **Instruction Set**:
   - 19-bit wide instructions with a 5-bit opcode and operands encoded for both register and immediate addressing.
   - Example operations:
     - Arithmetic: `ADD`, `SUB`
     - Logical: `AND`, `OR`, `XOR`, `NOT`
     - Shift: `SHL`, `SHR`
     - Multiplication: `MUL`
     - Memory: `LD`, `ST`

2. **Pipeline**:
   - Implements a basic three-stage pipeline: **Fetch**, **Decode**, and **Execute**.

3. **Register File**:
   - 8 general-purpose registers, each 19-bit wide.

4. **ALU**:
   - Handles all arithmetic and logical operations.
   - Supports both register-to-register and immediate operations.

5. **Memory Interface**:
   - Allows loading and storing data from/to external memory.

Detailed documentation of the architecture is available in `docs/architecture_spec.md`.

---

## **Instruction Set Architecture (ISA)**

### Instruction Format
- **19 bits total**:
  - `Opcode (5 bits)` + `Destination Register (3 bits)` + `Source Register 1 (3 bits)` + `Source Register 2/Immediate (8 bits)`

### Example Instructions:
| Opcode   | Mnemonic | Description                  |
|----------|----------|------------------------------|
| `00000`  | `ADD`    | Add two registers            |
| `00001`  | `SUB`    | Subtract two registers       |
| `00010`  | `AND`    | Logical AND                  |
| `00011`  | `OR`     | Logical OR                   |
| `00100`  | `SHL`    | Shift left by immediate value|
| `01100`  | `LD`     | Load from memory             |
| `01101`  | `ST`     | Store to memory              |

More details are in `docs/instruction_set.md`.

---

## **Simulation and Validation**

The testbench (`cpu_tb.v`) validates the CPU with four test cases:
1. **Addition** (`ADD R1 = R2 + R3`): Ensures correct arithmetic functionality.
2. **Logical AND** (`AND R1 = R2 & R3`): Validates logical operations.
3. **Load** (`LD`): Tests memory read functionality.
4. **Store** (`ST`): Tests memory write functionality.

### Running the Testbench
To simulate the design:
1. Use any Verilog simulator (e.g., ModelSim, Vivado, or Icarus Verilog).
2. Run the testbench:
   ```bash
   iverilog -o cpu_tb cpu_tb.v cpu.v
   vvp cpu_tb
