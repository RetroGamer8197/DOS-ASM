type:
    call readKey
    call handleKeys
    call moveCursor
    jmp type

handleKeys:
    mov [si], al
    cmp al, 0x08
    je backspace
    cmp ah, 0x01
    je clear
    cmp ah, 0x1C
    je enterPressed
    cmp ah, 0x52
    je install
    call printChar
    inc si
    ret

backspace:
    mov ax, si
    cmp ax, 0x4000
    je return
    mov al, 0x00
    dec si
    dec word [cursorX]
    call printChar
    dec word [cursorX]
    ret

loopCheckKey:
    mov ah, 0x00
    int 0x16
    cmp ah, bl
    jne loopCheckKey
    ret

readKey:
    mov ah, 0x00
    int 0x16
    mov dl, al
    ret