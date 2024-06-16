[ORG 0x7C00]
xor ax, ax
mov ds, ax
cld
mov sp, 0x1000

mov si, 0x3FFE
mov [si], dx

jmp start

%include "functions/sysdisk.asm"

printText:
    lodsb
    or al, al
    jz return
    mov ah, 0x0E
    mov bh, 0x00
    int 0x10
    jmp printText

start:
    mov ax, 0x0002
    int 0x10

    mov si, bootMsg
    cld
    call printText

    call loadSysFS

    mov di, kernelName
    call readSysFile

    mov si, 0x4000
    jmp 0x7E00

return:
    ret

hang:
    jmp hang

readSector:
    mov si, 0x3FFE
    mov dx, [si]
    mov si, 0x0000
    mov es, si
    mov ah, 0x02
    int 0x13
    cmp ah, 0x00
    jne printSysError
    ret

found:
    ret

bootMsg db "Loading from disk ...", 13, 10, 0

times 510 - ($-$$) db 0
db 0x55
db 0xAA