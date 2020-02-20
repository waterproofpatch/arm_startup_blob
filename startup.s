.section INTERRUPT_VECTOR, "x"
.global _Reset // make this readable from linker script for the entry point
_Reset: // mapped to ARM v? interrupt vector layout
  B Reset_Handler /* Reset */
  B . /* Undefined */
  B . /* SWI */
  B . /* Prefetch Abort */
  B . /* Data Abort */
  B . /* reserved */
  B . /* IRQ */
  B . /* FIQ */
 
// called on first boot
Reset_Handler:
  LDR sp, =stack_top
  BL c_entry
  B . // infinite loop
