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
    inc si
    inc di
    jmp checkFile

endFile:
    cmp ch, cl
    je found
    jmp nextFile

nextFile:
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
    mov ax, 0x0E0D
    int 0x10
    mov ax, 0x0E0A
    int 0x10
    mov si, 0x4200
    call printFiles
    ret
    
printFiles:
    cmp si, 0x4A00
    je found
    call printCurrentFile
    mov bx, si
    call newPrintLine
    and bl,0xF0
    add bx, 0x0010
    mov si, bx
    
    jmp printFiles
    
newPrintLine:
    mov ax, si
    and al, 0xF0
    mov si, ax
    cmp byte [si], 0x00
    je return
    mov ax, 0x0E0D
    int 0x10
    mov ax, 0x0E0A
    int 0x10
    ret

printCurrentFile:
    cmp byte [si], 0x00
    je found
    lodsb
    mov ah, 0x0E
    int 0x10
    inc dx
    mov dx, si
    and dl, 0x0F
    cmp dl, 0x0B
    je endFile
    jmp printCurrentFile

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