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

initDisplay:
    mov ax, 0x0002
    int 0x10
    ret

printText:
    lodsb
    or al, al
    jz return
    mov ah, 0x0E
    mov bh, 0x00
    int 0x10
    jmp printText

printdl:
    mov si, outputByte
    mov bl, dl
    shr bl, 0x04
    add bl, "0"
    mov [si], bl
    inc si
    mov bl, dl
    shl bl, 0x04
    shr bl, 0x04
    add bl, "0"
    mov [si], bl
    
    mov si, outputByte
    cld
    call printText
    ret