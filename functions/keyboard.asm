type:
    call readKey
    call handleKeys
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
    mov ah, 0x0E
    int 0x10
    inc si
    ret

backspace:
    mov ax, si
    cmp ax, 0x4000
    je return
    mov ax, 0x0E08
    mov bh, 0x00
    int 0x10
    mov ax, 0x0E20
    mov bh, 0x00
    int 0x10
    mov ax, 0x0E08
    mov bh, 0x00
    int 0x10
    mov byte [si], 0x00
    dec si
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