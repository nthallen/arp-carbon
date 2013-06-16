README.txt for Harvard Carbon Isotopes instrument

CPU Configuration:
  Versalogic Mamba VL-EBX-37F
    Manual says in order to use IRQs on the ISA bus, they must
    first be enabled in the BIOS setup, but there is no option
    to enable or disable IRQs in the BIOS setup.
    Only IRQs 3, 4, 5 and 10 go to ISA bus. We will use IRQ5,
    which is consistent with the Python config below.
    
    Apparently we have no need for the Firmbase support, so
    I have disabled it in the BIOS.
    
    [x] Check to see if CPU temp and board temp info is accessible
        in the same way as on Python: No it is not.
    [y] Test Xtreme/104 as RS-232
    
    BIOS: Configure eSATA connector to boot first, internal
    SATA second. Ubuntu config below.
  
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
    J5.P1.RX & .TX Jumpered for RS422 on Port 1
    
    /sbin/devc-ser8250 Driver needs to be invoked with -c option
    to note fast input clock:
      /sbin/devc-ser8250 -c 7372800/16 -u4 300,5

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
   
                               R   G
  Top LED is controlled by GPO 1 & 2
  Middle LED               GPO 3 & 4
  Bottom LED               GPO 5 & 6
  The first GPO is the Red LED, the second is green
  
  Turn on GPO:  FE 57 n
  Turn off GPO: FE 56 n
  Set Startup:  FE C3 n s (where s=1 for on, s=0 for off)
  
  Want to initialize all of these LEDs to be off, so:
  > Panel display text \xfe\xc3\x01\x00
  > Panel display text \xfe\xc3\x02\x00
  > Panel display text \xfe\xc3\x03\x00
  > Panel display text \xfe\xc3\x04\x00
  > Panel display text \xfe\xc3\x05\x00
  > Panel display text \xfe\xc3\x06\x00

Mamba CPU Die Temperature

Ubuntu on external drive
    Fixed IP (so not dependent on lab network)
    ssh in to perform copy operation.
    [Ultimately would be great to use pilot panel...]
    
    Switching between graphical and text interface:
      Edit /etc/default/grub
      set GRUB_CMDLINE_LINUX_DEFAULT to "quiet splash" for GUI
      and "text" for text
      Run sudo update-grub to commit changes
