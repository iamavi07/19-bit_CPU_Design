# Instruction Set Architecture (ISA)

## Overview
The 19-bit CPU uses a custom instruction set designed to provide efficient computation for general-purpose and specialized tasks like signal processing. The CPU supports arithmetic, logical, shift operations, and basic memory operations.

## Instruction Format
Each instruction is **19 bits** wide and consists of the following components:
- **Opcode** (5 bits): Determines the operation to be performed.
- **Destination Register** (3 bits): Specifies the register where the result is stored.
- **Source Register 1** (3 bits): Specifies the first operand.
- **Source Register 2 or Immediate** (8 bits): Specifies the second operand or an immediate value.

### **Instruction Breakdown**
- **Opcode**: 5 bits
- **Destination Register (Dst)**: 3 bits
- **Source Register 1 (Src1)**: 3 bits
- **Source Register 2 (Src2)** / **Immediate**: 8 bits

### Instruction Table
| Opcode   | Mnemonic | Description                                                                 |
|----------|----------|-----------------------------------------------------------------------------|
| `00000`  | `ADD`    | Add two registers and store the result in the destination register.        |
| `00001`  | `SUB`    | Subtract the second register from the first and store in the destination.  |
| `00010`  | `AND`    | Perform bitwise AND on two registers and store the result.                 |
| `00011`  | `OR`     | Perform bitwise OR on two registers and store the result.                  |
| `00100`  | `SHL`    | Perform a left shift on the first register by the immediate value.         |
| `00101`  | `SHR`    | Perform a right shift on the first register by the immediate value.        |
| `01100`  | `LD`     | Load data from memory at the specified address and store in a register.    |
| `01101`  | `ST`     | Store the data from a register to the memory at the specified address.     |
| `01000`  | `MUL`    | Multiply two registers and store the result in the destination register.  |

### Detailed Operation Example

#### **ADD Operation (Opcode: `00000`)**
- **Format**: `ADD R1 = R2 + R3`
- **Opcode**: `00000` (Add operation)
- **Source Registers**: `R2` and `R3`
- **Destination Register**: `R1`
- **Operation**: Adds the contents of `R2` and `R3` and stores the result in `R1`.

**Example:**
If `R2 = 10` and `R3 = 5`, the `ADD` instruction will result in `R1 = 15`.

---

## Immediate vs. Register Addressing

- **Register Addressing**: Instructions like `ADD`, `AND`, `OR`, and `MUL` use registers as operands.
- **Immediate Addressing**: Instructions like `SHL` and `SHR` take an immediate value (8 bits) for shifting the register contents.

---

## Memory Operations
- **Load (LD)**: The `LD` instruction loads data from a memory address into a register.
- **Store (ST)**: The `ST` instruction stores data from a register into a specified memory address.

---
