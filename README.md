# DOS-ASM

DOS-ASM is my self-created operating system made entirely in 8086 Assembly. Each of the files in the functions subdirectory contains subroutines that act as the drivers for this OS.

This is currently an early release and not intended to be a fully functioning OS yet

The OS is designed in 16 bit real mode and uses BIOS interrupts for most of its functionality. It has been tested on 3 machines:

* A QEMU VM
* A system based around a Core2Duo E7200
* A Lenovo Thinkpad T430

Currently, this OS does not have file system support but I aim to either implement FAT32 and/or my own file system in the future. Using a diskette image, the OS has the ability to install itself to a HDD using the BIOS Interrupt 0x13

To assemble using NASM, run:

  <./assemble>

**COMMANDS LIST**

*INSTALL* - installs the operating system onto the primary hard disk (disk 80)

*CLS* - clears the screen

*ECHO disk* - prints the number of the current disk (A: = 00, C: = 80)

*CD [disk letter]:* - changes the current working disk

*VER* - prints the current OS version string

*DIR* - lists all the files in the current directory