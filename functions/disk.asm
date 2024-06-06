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

printError:
    mov si, errorMsg
    cld
    call printText
    ret

loadFS:
    mov bx, 0x4200
    mov cx, 0x0002
    mov al, 0x04
    call readSector
    ret

checkFile:
    mov dx, si
    and dl, 0x0F
    cmp dl, 0x0C
    je endFile
    mov cl, [di]
    mov ch, [si]
    cmp ch, 0x00
    je endFile
    cmp cl, 0x00
    je nextFile
    inc si
    inc di
    jmp checkFile

endFile:
    cmp ch, cl
    je found
    jmp nextFile

nextFile:
    add ax, 0x0010
    and bx, 0xFFF0
    cmp ax, 0x4A00
    je fileNotFound
    mov si, ax
    mov di, bx
    jmp checkFile

searchForFile:
    mov bx, di
    mov ax, si
    jmp checkFile

fileNotFound:
    mov ax, 0xFFFF
    ret

found:
    ret

readKernel:
    mov si, kernelName
    cld
    call printText
    mov si, 0x4200
    cld
    call printText
    mov si, 0x4200
    mov di, kernelName
    call searchForFile
    mov bx, 0x7E00
    cmp ax, 0xFFFF
    jne loadFile
    mov si, kernelNotFound
    call printText
    jmp hang

loadFile:               ;FILE = 12B NAME, 1B START SECTOR, 1B CYLINDER, 1B FILE SIZE (SECTORS)
    add ax, 0x0C
    mov si, ax
    lodsb
    mov cl, al
    lodsb
    mov ch, al
    lodsb
    call readSector
    ret

kernelName db "KERNEL.BIN", 0, 0
kernelNotFound db "Kernel not found", 0
errorMsg db "Disk Access Failed", 0

diskA db "A:\> ", 0
diskC db "C:\> ", 0
unknown db "U:\> ", 0