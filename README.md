# SystemVerilog Modules

A collection of digital hardware designs implemented in SystemVerilog, developed from fundamental combinational logic through sequential
circuits, arithmetic units, memory, FSMs, datapaths, and communication interfaces.

The project focuses on writing synthesizable RTL, building dedicated testbenches, verifying designs with Verilator, and inspecting simulation
waveforms using Surfer.

---

## Overview

This repository contains RTL implementations of common digital design and computer architecture building blocks.

The designs are organized by function:

```
sysverilog-modules/
  ├── combinational/
  ├── sequential/
  ├── arithmetic/
  ├── memory/
  ├── fsm/
  ├── datapath/
  └── communication/
```
Each design is developed with a corresponding testbench and can be compiled and simulated independently.

---

## Project Structure

```
.
├── combinational/
│   ├── gates/
│   ├── mux/
│   ├── demux/
│   ├── decoder/
│   ├── encoder/
│   ├── comparator/
│   ├── parity/
│   ├── converters/
│   └── shifters/
│
├── sequential/
│   ├── flip_flops/
│   ├── registers/
│   ├── shift_registers/
│   ├── counters/
│   └── timers/
│
├── arithmetic/
│   ├── adders/
│   ├── subtractors/
│   ├── multipliers/
│   ├── dividers/
│   └── alu/
│
├── memory/
│   ├── rom/
│   ├── ram/
│   ├── fifo/
│   └── reg_file/
│
├── fsm/
│   ├── mealy/
│   └── moore/ 
│
├── datapath/
│   ├── accumulator/
│   ├── crc/
│   └── pipeline/
│
└── communication/
    ├── uart/
    ├── spi/
    ├── i2c/
    └── axi/
```
---

## Verification

Each RTL module is paired with a dedicated SystemVerilog testbench.

The general structure is:
```
design/
├── rtl/
│   └── module.sv
│
├── tb/
│   └── module_tb.sv
│
└── Makefile
```

Testbenches are used to:

* Apply input stimulus
* Generate clocks and reset
* Verify expected outputs
* Exercise different operating conditions
* Produce waveform traces for debugging

---

## Simulation

The project uses Verilator for RTL compilation and simulation.

Build a module:
```
make build
```
Run the simulation:
```
make run
```
Build and open the waveform:
```
make wave
```
Clean generated files:
```
make clean
```
Typical workflow:
```
cd communication/uart
make wave
```

---

## Waveform Analysis

Simulation traces are generated using Verilator’s VCD tracing support:
```
verilator --binary --trace
```
Waveforms are viewed using Surfer.

The waveforms are organized to show the most important signals first:
```
Clock / Reset -> Inputs -> Control signals -> Outputs -> Internal state
```
Internal signals are exposed when they are useful for understanding the RTL implementation.

---

## Digital Logic

### Combinational Logic

**Fundamental combinational circuits implemented in SystemVerilog.**

*Logic Gates*

* AND
* OR
* NOT
* NAND
* NOR
* XOR
* XNOR

*Multiplexers*

* 2:1 MUX
* 4:1 MUX
* 8:1 MUX

*Demultiplexers*

* 1:2 DEMUX
* 1:4 DEMUX
* 1:8 DEMUX

*Decoders*

* 2-to-4 decoder
* 3-to-8 decoder

*Encoders*

* 4-to-2 encoder
* 8-to-3 encoder
* Priority encoder

*Comparators*

* 1-bit comparator
* 4-bit comparator
* Parameterized comparator

*Parity*

* Even parity generator
* Odd parity generator
* Parity checker

*Code Converters*

* Binary → Gray
* Gray → Binary
* Binary → BCD

*Shifters*

* Logical left shift
* Logical right shift
* Arithmetic right shift
* Barrel shifter


### Sequential Logic

**Sequential designs are clock-driven and demonstrate state storage and timing behavior.**

*Flip-Flops*

* SR flip-flop
* JK flip-flop
* D flip-flop
* T flip-flop

*Registers*

* Basic register
* Register with enable

*Shift Registers*

* SISO
* SIPO
* PISO
* PIPO
* Bidirectional shift register
* Universal shift register

*Counters*

* Up counter
* Down counter
* Up/Down counter
* Mod-N counter
* Ring counter
* Johnson counter

*Timers*

* Clock divider
* Pulse generator
* Programmable timer
* Watchdog timer
* PWM generator


### Arithmetic

**Arithmetic RTL designs demonstrate different hardware implementations of mathematical operations.**

*Adders*

* Half adder
* Full adder
* Ripple-carry adder
* Carry-lookahead adder
* Carry-save adder
* Carry-select adder
* Carry-skip adder
* BCD adder

*Subtractors*

* Half subtractor
* Full subtractor
* Ripple-borrow subtractor

*Multipliers*

* Wallace-tree multiplier
* Booth multiplier
* Sequential multiplier

*Dividers*

* Restoring divider
* Non-restoring divider
* Sequential divider

*ALU*

* 4-bit ALU
* 8-bit ALU


### Memory

**Parameterized memory structures used in digital systems and processor architectures.**

*ROM*

Read-only memory implementation with parameterized depth and width.

*RAM*

Parameterized RAM with:

* Synchronous write
* Asynchronous read

*FIFO*

Synchronous FIFO with:

* Read/write pointers
* Full detection
* Empty detection
* Occupancy tracking

*Register File*

Parameterized register file supporting:

* Two asynchronous read ports
* One synchronous write port
* Configurable data width
* Configurable number of registers


### Finite State Machines

Finite state machine implementations using both major FSM styles.

*Mealy FSM*

Output depends on:

Current State + Input

Includes a sequence detector.

*Moore FSM*

Output depends on:

Current State

Includes a sequence detector.


### Datapath

**Datapath-oriented RTL components used in larger digital systems.**

*Accumulator*

Parameterized accumulator supporting:

* Reset
* Enable
* Sequential accumulation

*CRC*

CRC generator/checker implementation for data integrity.

*Pipeline*

Multi-stage synchronous pipeline demonstrating data propagation through sequential stages.


### Communication Interfaces

**Basic communication protocol implementations.**

*UART*

UART transmitter and receiver supporting:

* 8-bit data
* No parity
* 1 stop bit
* Parameterized clock frequency
* Parameterized baud rate

```
UART TX ───────> UART RX
      TX data
```

*SPI*

SPI Master and Slave implementations.

Current design:

* 8-bit transfers
* MSB first
* SPI Mode 0
* Master-generated clock
* Separate MOSI/MISO
* Chip select

```
        SPI
┌───────────────┐
│    Master     │
│               │
│ SCLK ────────>│
│ MOSI ────────>│
│ MISO <────────│
│ CS   ────────>│
└───────────────┘
        │
        ▼
┌───────────────┐
│     Slave     │
└───────────────┘
```

*I2C*

Basic I²C Master and Slave implementations.

Features:

* 7-bit addressing
* Single-byte transfers
* START condition
* STOP condition
* ACK/NACK
* Open-drain SDA behavior
* Clock-controlled SCL
  
```
SCL ────────────────>
SDA <───────────────>
```

*AXI4-Lite*

Basic AXI4-Lite Master and Slave implementations.

Supported channels:

Write

AW -> Write Address
W  -> Write Data
B  -> Write Response

Read

AR -> Read Address
R  -> Read Data

The implementation demonstrates the AXI valid/ready handshake mechanism and single-beat transactions.

---

## Design Goals

The project is built around a few goals:

* Learn RTL design by implementing hardware from the ground up
* Understand how digital circuits translate into synthesizable RTL
* Practice SystemVerilog coding conventions
* Develop reusable parameterized modules
* Build testbenches alongside RTL
* Use waveform-based debugging
* Understand common hardware interfaces
* Progress from basic digital logic toward processor-level hardware

---

## Development Approach

The designs generally follow this workflow:
```
Specification -> RTL Design -> Testbench -> Verilator Compilation -> Simulation -> Waveform Analysis -> Debug / Improve
```
Verilator warnings are treated as useful feedback rather than simply being disabled. In particular, signal width mismatches are addressed
explicitly to keep the RTL well defined.
