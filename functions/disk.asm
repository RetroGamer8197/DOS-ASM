readSector:
    mov si, 0x3FFE
    mov dx, [si]
    mov si, 0x0000
    mov es, si
    mov ah, 0x02
    int 0x13
    cmp ah, 0x00
    jne printError
    ret

printError:
    mov si, errorMsg
    cld
    call printText
    ret

loadFS:
    mov bx, 0x4200
    mov cx, 0x0002
    mov al, 0x04
    call readSector
    ret

checkFile:
    mov dx, si
    and dl, 0x0F
    cmp dl, 0x0C
    je endFile
    mov cl, [di]
    mov ch, [si]
    cmp ch, cl
    jne endFile
    cmp cl, 0x00
    je endFile
    inc si
    inc di
    jmp checkFile

endFile:
    cmp ch, cl
    je found
    jmp nextFile

nextFile:
    and ax, 0xFFF0
    add ax, 0x0010
    and bx, 0xFFF0
    cmp ax, 0x4A00
    je fileNotFound
    mov si, ax
    mov di, bx
    jmp checkFile

searchForFile:
    mov bx, di
    mov ax, si
    jmp checkFile

fileNotFound:
    mov ax, 0xFFFF
    ret

found:
    ret

listDiskContents:
    call newLine
    mov si, 0x41F0
    call printFiles
    ret

printFiles:
    mov dx, si
    and dl, 0xF0
    add dx, 0x10
    mov si, dx
    cmp dh, 0x4A
    je return
    cmp byte [si], 0x00
    je printFiles
    call printCurrentFile
    call newLine
    jmp printFiles

printCurrentFile:
    mov al, [si]
    cmp al, 0x00
    call printChar
    mov dx, si
    inc si
    and dl, 0x0F
    cmp dl, 0x0B
    jne printCurrentFile
    ret

loadFile:               ;FILE = 12B NAME, 1B START SECTOR, 1B CYLINDER, 1B FILE SIZE (SECTORS)
    add ax, 0x0C
    mov si, ax
    lodsb
    mov cl, al
    lodsb
    mov ch, al
    lodsb
    call readSector
    ret

%include "functions/sysdisk.asm"

errorMsg db "Disk Access Failed", 0

diskA db "A:\> ", 0
diskC db "C:\> ", 0
unknown db "U:\> ", 0