printDisk:
    mov si, 0x3FFE
    mov dx, [si]
    cmp dl, 0x80
    je printC
    cmp dl, 0x00
    je printA
    mov si, unknown
    cld
    call printText 
    ret

printA:
    mov si, diskA
    cld
    call printText
    ret

printC:
    mov si, diskC
    cld
    call printText
    ret

newLine:
    mov ax, 0x0E0D
    mov bh, 0x00
    int 0x10
    mov ax, 0x0E0A
    mov bh, 0x00
    int 0x10
    ret