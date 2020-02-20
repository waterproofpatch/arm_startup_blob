# Blob Loader
Create a simple binary blob to load directly on an ARM chip.

The startup.s script lays out the interrupt vector table according to how ARM 
processors handle exceptions. Noteably, the 'entry point' is at the Reset 
handler, which is implemented as a simple branch into c_entry.

The blob.ld linker script takes a compiled startup.o and maps the entry point 
(base address zero_ to _Reset, and maps the interrupt vector at address 0 
(again, conforming to ARM's initializing PC to 0 on power up). 

The linker script then lays the remaining .text section, followed by data and 
bss. Then it 8 byte aligns the stack, which it creates for 0x1000 bytes. 
stack_top, referenced in startup.s during Reset, points at the top of this 
stack section and is loaded into the stack pointer before c_entry is called.

## Build

```
make
```

## Run

Won't run on OS, needs to be loaded onto an ARM chip that boots at address 0 (reset handler).

## Inspect

Using objdump, we can see the disassembled binary (test.elf) that we should be able to load directly onto an ARM-based MCU:
```
make disas
```

Noteably: Address 0 points at the arm instruction to branch to our reset handler.
Our reset handler calls out implementation, c_entry, then loops indefinately.
