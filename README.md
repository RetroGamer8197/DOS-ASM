# DOS-ASM

DOS-ASM is my self-created operating system made entirely in 8086 Assembly. Each of the files in the functions subdirectory contains subroutines that act as the drivers for this OS.

This is currently an early release and not intended to be a fully functioning OS yet

The OS is designed in 16 bit real mode and uses BIOS interrupts for most of its functionality. It has been tested on 3 machines:

* A QEMU VM
* A system based around a Core2Duo E7200
* A Lenovo Thinkpad T430

Currently, this OS does not have file system support but I aim to either implement FAT32 and/or my own file system in the future. Using a diskette image, the OS has the ability to install itself to a HDD using the BIOS Interrupt 0x13

To assemble using NASM, run:

  `./assemble`

**COMMANDS LIST**

*INSTALL* - installs the operating system onto the primary hard disk (disk 80)

*CLS* - clears the screen

*ECHO disk* - prints the number of the current disk (A: = 00, C: = 80)

*CD [disk letter]:* - changes the current working disk

*VER* - prints the current OS version string

*DIR* - lists all the files in the current directory


**MEMORY MAP:**
`0x0000-0x3FFD` - Unused (as of v0.2.2)

`0x3FFE-0x3FFF` - Stores the boot disk information

`0x4000-0x41FF` - Stores the currently typed command(s)

`0x4200-0x4A00` - Stores the file system information of the current working disk

`0x4A00-0x7BFF` - Unused (as of v0.2.2)

`0x7C00-0x7DFF` - Stores the bootloader

`0x7E00-0x87FF` - Stores the kernel

`0x8800-0xF1FF` - Unused (as of v0.2.2)

`0xF200-0xFA00` - Stores the boot disk file system information