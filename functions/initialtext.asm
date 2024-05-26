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