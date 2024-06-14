# DOS-ASM

DOS-ASM is my self-created operating system made entirely in 8086 Assembly. Each of the files in the functions subdirectory contains subroutines that act as the drivers for this OS.

This is currently an early release and not intended to be a fully functioning OS yet

The OS is designed in 16 bit real mode and uses BIOS interrupts for most of its functionality. It has been tested on 3 machines:

* A QEMU VM
* A system based around a Core2Duo E7200
* A Lenovo Thinkpad T430

To assemble using NASM, run:

  `./assemble`

**COMMANDS LIST**

*INSTALL* - installs the operating system onto the primary hard disk (disk 80)

*CLS* - clears the screen

*ECHO disk* - prints the number of the current disk (A: = 00, C: = 80)

*CD [disk letter]:* - changes the current working disk

*VER* - prints the current OS version string

*DIR* - lists all the files in the current directory

**FILE SYSTEM**

As of v0.2.1, the OS has support for a custom file system which uses the first 2.5 KB after the boot sector to store the information about each file. Each file uses 16 bytes to define itself:

`0x0-0xB` - File name (max 12 characters)

`0xC` - Start sector

`0xD` - Cylinder

`0xE` - File size (sectors)

`0xF` - Currently unused but may be used in the future to define a parent directory


**MEMORY MAP:**

`0x00000-0x00FFF` - Allocated to the stack

`0x01000-0x03FFD` - Unused (as of v0.3)

`0x03FFE-0x03FFF` - Stores the boot disk information

`0x04000-0x041FF` - Stores the currently typed command(s)

`0x04200-0x04A00` - Stores the file system information of the current working disk

`0x04A00-0x07BFF` - Unused (as of v0.3)

`0x07C00-0x07DFF` - Stores the bootloader

`0x07E00-0x08DFF` - Stores the kernel

`0x08E00-0x0F1FF` - Unused (as of v0.3)

`0x0F200-0x0F9FF` - Stores the boot disk file system information

`0x0FA00-0x9FFFF` - Unused (as of v0.3)

`0xA0000-0xBFFFF` - VGA Video Buffer

`0xC0000-0xFFFFF` - Unused (as of v0.3)
