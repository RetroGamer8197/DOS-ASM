cmpStr:
    mov cl, [di]
    mov ch, [si]
    cmp ch, cl
    je cmpContinue
    add ch, 0x20
    cmp ch, cl
    jne failCmp
cmpContinue:
    cmp byte [di], 0x0D
    je endCmp
    inc si
    inc di
    jmp cmpStr

endCmp:
    mov al, 0x00
    mov si, 0x3FFD
    mov byte [si], 0x00
    ret

failCmp:
    mov al, 0x01
    ret