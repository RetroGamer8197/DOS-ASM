[ORG 0x7E00]

call initDisplay

mov si, VersionName + 2
cld
call printText

call nextDOSLine
mov si, 0x4000
jmp type

hang:
    jmp hang
return:
    ret

VersionName db 13, 10, "DOS-ASM v0.21", 0

%include "functions/cmd.asm"
%include "functions/disk.asm"
%include "functions/display.asm"
%include "functions/keyboard.asm"
%include "functions/string.asm"

continueText db "Second sector loaded ...", 13, 10, 0
clearMsg db "DOS-ASM v0.1", 13, 10, 0
installText db 13, 10, "The OS was just installed", 0

outputByte db 0, 0
zero db 0, 0

times 3584 - ($-$$) db 0

SectorTest:
mov si, finalSector
cld
call printText
ret
finalSector db "Success!", 13, 10, 0

times 4096 - ($-$$) db 0

