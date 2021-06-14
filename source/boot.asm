bits 16
org 0x7c00

mov bp, 0x7c00
mov sp, bp

mov ax, 0600h
mov bh, 4fh
mov cx, 0000h
mov dx, 184fh
int 10h

mov ax, 0600h
mov bh, 3fh
mov cx, 0100h
mov dx, 184fh
int 10h

; Call the starting strings
Start:
    mov bx, W
    call Print

    mov bx, S
    call Print

    mov bx, CMD
    call Print

; Check if key is pressed
KeyLoop:
    mov ah, 0
    int 16h

    cmp al, 13
    je .C

    cmp al, 'i'
    je .IN

    jmp KeyLoop

    .C:
        mov bx, NCS
        call Print

        mov bx, CMDS
        call Print

        mov bx, CMD
        call Print

        jmp KeyLoop
    
    .IN:
        mov bx, I
        call Print

        mov bx, CMDS
        call Print

        mov bx, S
        call Print

        mov bx, OI
        call Print

        mov bx, S
        call Print

        mov bx, CMD
        call Print

        jmp KeyLoop

jmp $

Print:
    mov ah, 0x0e
    .Loop:
    cmp [bx], byte 0
    je .Exit
        mov al, [bx]
        int 0x10
        inc bx
        jmp .Loop
    .Exit:
    ret

; Strings
W:
    db 'Obbitt OS v0.3                                                                  ', 0
OI:
    db 'Obbitt is a free, open-source operating system maintained by the Obbitt Team    ', 0
S:
    db '                                                                                ', 0
CMD:
    db 'ObbittShell >> ', 0
CMDS:
    db '                                                                ', 0
NCS:
    db ' ', 0

; Keystroke Strings
I:
    db 'i', 0

times 510-($-$$) db 0
dw 0xaa55