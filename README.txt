README.txt for Harvard Carbon Isotopes instrument

CPU Configuration:
  Versalogic Python VL-EBX-11
  BIOS requires PS/2 keyboard, not USB
    Actually, the VL-EBX-11 currently in /net/hci responds to USB keyboard.
    Probably smart to install the connector in case another board has to
    be swapped in at some point and does not respond to USB for some reason.
  Drive C: Secondary/Slave (for compact flash)
  PCI INT B => IRQ10 (instead of IRQ5)
  ISA IRQ 5 Enabled (for Xtreme/104 board)
  COM1 => IRQ4 (for use with inverter)
  COM2 => IRQ3 (default, for use with SPAN)
  COM3 => IRQ7 (for use with laser altimeter) (need to test this)
  COM4 => Disabled
  
  Xtreme/104:
    J1.6 Jumpered to select fast clock
    J1.* open for I/O address selection 0x300
    C5 Jumpered for IRQ5 (Mode 1, one IRQ)
    J5 P1 RX & TX Jumpered for RS422 on Port 1
    
    /sbin/devc-ser8250 Driver needs to be invoked with -c option
    to note fast input clock.

Need PS/2 keyboard Connector for BIOS, but not for QNX6.
