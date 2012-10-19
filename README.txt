README.txt for Harvard Carbon Isotopes instrument

CPU Configuration:
  Versalogic Python VL-EBX-11
  BIOS requires PS/2 keyboard, not USB
  Drive C: Secondary/Slave (for compact flash)
  IRQ4 of ISA USE Enabled (for Xtreme/104 board)
  COM1 => IRQ10 (for use with laser altimeter)
  COM2 => IRQ3 (default, for use with SPAN)
  COM3 => Disabled
  COM4 => Disabled
  
  Xtreme/104:
    J1.6 Jumpered to select fast clock
    J1.* open for I/O address selection 0x300
    C4 Jumpered for IRQ4 (Mode 1, one IRQ)
    J5 P1 RX & TX Jumpered for RS422 on Port 1
    
    /sbin/devc-ser8250 Driver needs to be invoked with -c option
    to note fast input clock.

Need PS/2 keyboard Connector for BIOS, but not for QNX6.
