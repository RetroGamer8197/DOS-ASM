readSector:
    mov si, 0x3FFE
    mov dx, [si]
    mov si, zero
    mov es, [si]
    mov ah, 0x02
    int 0x13
    ret

%include "data/diskdata.inc"