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

Need PS/2 keyboard Connector for BIOS, but not for QNX6. Or maybe not.

LK204:
  Write FIFO length is 64 characters.
  I2C Transmission rate is about 10 kbps or 1kBps
  
  Special characters for SEAS Shield:
    0: upper left:    \xfe\x4e\x00\x1f\x1f\x11\x11\x1f\x15\x10\x10
    1: upper middle:  \xfe\x4e\x01\x1f\x1f\x11\x11\x1f\x0a\x04\x0c
    2: upper right:   \xfe\x4e\x02\x1f\x1f\x11\x11\x1f\x15\x01\x01
    3: middle left:   \xfe\x4e\x03\x08\x0a\x0f\x09\x04\x04\x02\x01
    4: middle middle: \xfe\x4e\x04\x06\x14\x1f\x05\x0c\x04\x06\x0c
    5: middle right:  \xfe\x4e\x05\x02\x12\x1e\x0a\x04\x04\x08\x10
    6: bottom middle: \xfe\x4e\x06\x1f\x04\x00\x00\x00\x00\x00\x00
  
  It is not a good idea to write to the LK204 while the write buffer
  is draining. When sending a string, all but the last char is
  is marked to suspend draining of the write queue in order to
  ensure that complete escape sequences get delivered in a timely
  manner. The proper way to send large amounts of data like this is
  to send less than 64 characters, then enable output and wait for
  the output fifo to drain completely before writing any more.
  In this case, we could send the first five lines (55 chars), then
  drain. 55 characters should drain in about 55 msecs, so transmitting
  on the next second is pretty much guaranteed to be OK. If we had
  a dedicated driver, we could do it even faster, but since we don't
  do this that often, that really isn't necessary.

      > Panel display text \xfe\x4e\x00\x1f\x1f\x11\x11\x1f\x15\x10\x10\
      > Panel display text \xfe\x4e\x01\x1f\x1f\x11\x11\x1f\x0a\x04\x0c\
      > Panel display text \xfe\x4e\x02\x1f\x1f\x11\x11\x1f\x15\x01\x01\
      > Panel display text \xfe\x4e\x03\x08\x0a\x0f\x09\x04\x04\x02\x01\
      > Panel display text \xfe\x4e\x04\x06\x14\x1f\x05\x0c\x04\x06\x0c
   +1 > Panel display text \xfe\x4e\x05\x02\x12\x1e\x0a\x04\x04\x08\x10\
      > Panel display text \xfe\x4e\x06\x1f\x04\x00\x00\x00\x00\x00\x00\
      > Panel display text \xfe\x58\n \x00\x01\x02 AndersonGroup\n\
      > Panel display text  \x03\x04\x05 Harvard SEAS\n\
      > Panel display text   \x06
      
    12345678901234567890
   1     
   2 012 Anderson Group
   3 345 Harvard SEAS
   4  6  