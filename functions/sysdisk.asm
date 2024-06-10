searchForSysFile:
    mov bx, di
    mov ax, si
    jmp checkSysFile

readSector:
    mov si, 0x3FFE
    mov dx, [si]
    mov si, 0x0000
    mov es, si
    mov ah, 0x02
    int 0x13
    cmp ah, 0x00
    jne printError
    ret

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
    je endFile
    mov cl, [di]
    mov ch, [si]
    cmp ch, cl
    jne endFile
    inc si
    inc di
    jmp checkSysFile

SysFileNotFound:
    mov ax, 0x0000
    ret

found:
    ret

printError:
    mov si, errorMsg
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

readKernel:
    mov si, 0xF200
    mov di, kernelName
    call searchForSysFile
    mov bx, 0x7E00
    cmp ax, 0x0000
    jne loadKernel
    mov si, kernelNotFound
    call printText
    jmp hang

loadKernel:               ;FILE = 12B NAME, 1B START SECTOR, 1B CYLINDER, 1B FILE SIZE (SECTORS)
    add ax, 0x0C
    mov si, ax
    lodsb
    mov cl, al
    lodsb
    mov ch, al
    lodsb
    call readSector
    ret

endFile:
    cmp ch, cl
    je found
    jmp SysNextFile

kernelName db "KERNEL.BIN", 0, 0
kernelNotFound db "Kernel not found", 0
errorMsg db "Disk Access Failed", 0