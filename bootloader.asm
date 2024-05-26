%include "functions/initialtext.asm"
%include "functions/disk.asm"
%include "functions/bootkeyboard.asm"

start:
    call initDisplay

    mov si, bootMsg
    cld
    call printText

    mov al, 0x04
    mov cx, 0x0002
    mov bx, 0x7E00
    call readSector

    call nextSector

    mov bl, 0x1C
    call loopCheckKey

    mov si, enterMsg
    cld
    call printText

    mov bl, 0x1C
    call loopCheckKey

    call initDisplay

    mov si, clearMsg
    cld
    call printText

    call printDisk

    mov si, 0x4000
    jmp type

return:
    ret

hang:
    jmp hang

%include "data/bootdata.inc"

times 510 - ($-$$) db 0
db 0x55
db 0xAA