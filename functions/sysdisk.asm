searchForSysFile:
    mov bx, di
    mov ax, si
    jmp checkSysFile

loadSysFS:
    mov bx, 0xF200
    mov cx, 0x0002
    mov al, 0x04
    call readSector
    ret

checkSysFile:
    mov dx, si
    and dl, 0x0F
    cmp dl, 0x0C
    je endSysFile
    mov cl, [di]
    mov ch, [si]
    cmp ch, cl
    jne endSysFile
    inc si
    inc di
    jmp checkSysFile

SysFileNotFound:
    mov ax, 0x0000
    ret

printSysError:
    mov si, SysErrorMsg
    cld
    call printText
    ret

SysNextFile:
    add ax, 0x0010
    and bx, 0xFFF0
    cmp ax, 0xFA00
    je SysFileNotFound
    mov si, ax
    mov di, bx
    jmp checkSysFile

readSysFile:
    mov si, 0xF200
    call searchForSysFile
    mov bx, 0x7E00
    cmp ax, 0x0000
    jne loadSysFile
    mov si, systemFileNotFound
    call printText
    jmp hang

loadSysFile:               ;FILE = 12B NAME, 1B START SECTOR, 1B CYLINDER, 1B FILE SIZE (SECTORS)
    add ax, 0x0C
    mov si, ax
    lodsb
    mov cl, al
    lodsb
    mov ch, al
    lodsb
    call readSector
    ret

endSysFile:
    cmp ch, cl
    je found
    jmp SysNextFile

kernelName db "KERNEL.BIN", 0, 0
systemFileNotFound db "Kernel not found!", 0
SysErrorMsg db "Disk Access Failed! Boot Unsuccessful!", 0