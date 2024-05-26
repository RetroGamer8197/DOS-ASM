[ORG 0x7C00]
xor ax, ax
mov ds, ax
cld

mov si, 0x3FFE
mov [si], dx

jmp start

VersionName db 13, 10, "DOS-ASM v0.1", 0

%include "bootloader.asm"

nextSector:
    mov si, continueText
    cld
    call printText
    ret

%include "functions/cmd.asm"
%include "functions/display.asm"
%include "functions/keyboard.asm"
%include "functions/string.asm"

%include "data/maindata.inc"

times 4096 - ($-$$) db 0
