enterPressed:
    mov si, 0x3FFD
    mov byte [si], 0x01

    ;install
    mov si, 0x4000
    mov di, installCmd
    call cmpStr
    cmp al, 0x00
    je install

    ;cls
    mov si, 0x4000
    mov di, clsCmd
    call cmpStr
    cmp al, 0x00
    je clear

    ;cd C:
    mov si, 0x4000
    mov di, cd_CCmd
    call cmpStr
    cmp al, 0x00
    je cd_C
    
    ;cd A:
    mov si, 0x4000
    mov di, cd_ACmd
    call cmpStr
    cmp al, 0x00
    je cd_A

    ;dir
    mov si, 0x4000
    mov di, dirCmd
    call cmpStr
    cmp al, 0x00
    je dir

    ;printDisk:
    mov si, 0x4000
    mov di, printdlCmd
    call cmpStr
    cmp al, 0x00
    je printDiskDL

    ;ver:
    mov si, 0x4000
    mov di, verCmd
    call cmpStr
    cmp al, 0x00
    je printVer

    ;ver:
    mov si, 0x4000
    mov di, verCmd
    call cmpStr
    cmp al, 0x00
    je printVer

    mov si, 0x3FFD
    cmp byte [si], 0x00
    jne failCmd

    call nextDOSLine
    ret

nextDOSLine:
    call newLine
    call printDisk
    mov si, 0x4000
    ret

cd_C:
    mov si, 0x3FFE
    mov dx, 0x0080
    mov [si], dx
    call nextDOSLine
    ret

cd_A:
    mov si, 0x3FFE
    mov dx, 0x0000
    mov [si], dx
    call nextDOSLine
    ret

clear:
    call initDisplay
    call printDisk
    mov si, 0x4000
    ret

dir:
    call listDiskContents
    call nextDOSLine
    ret

install:
    mov ax, 0x0301
    mov dx, 0x0080
    mov bx, 0x7C00
    mov cx, 0x0000
    mov es, cx
    mov cx, 0x0001
    int 0x13
    mov ax, 0x0305
    mov dx, 0x0080
    mov bx, 0x4200
    mov cx, 0x0000
    mov es, cx
    mov cx, 0x0002
    int 0x13
    mov ax, 0x0308
    mov dx, 0x0080
    mov bx, 0x7E00
    mov cx, 0x0000
    mov es, cx
    mov cx, 0x0006
    int 0x13
    mov si, installText
    cld
    call printText
    call nextDOSLine
    ret

printDiskDL:
    mov ax, 0x0E0D
    int 0x10
    mov ax, 0x0E0A
    int 0x10
    mov si, 0x3FFE
    mov dl, [si]
    call printdl
    call nextDOSLine
    ret

printVer:
    mov si, VersionName
    cld
    call printText
    call nextDOSLine
    ret

failCmd:
    mov si, invalidCmd
    call printText
    call nextDOSLine
    ret

invalidCmd db 13, 10, "Invalid command!", 0

installCmd db "install", 0x0D
cd_ACmd db "cd a:", 0x0D
cd_CCmd db "cd c:", 0x0D
clsCmd db "cls", 0x0D
dirCmd db "dir", 0x0D
printdlCmd db "echo disk", 0x0D
verCmd db "ver", 0x0D