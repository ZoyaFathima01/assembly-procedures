section .data
    newline db 0xA  ; ASCII line feed (LF)

section .bss
    char resb 1

section .text
    global _start

; ========== MAIN ==========
_start:
    mov cl, 'A'        ; Start with ASCII 'A'

print_loop:
    cmp cl, 'Z' + 1    ; End at ASCII 'Z'
    jge done

    push cx            ; Save current char
    call print_char    ; Call procedure to print char + newline
    pop cx             ; Restore char

    inc cl             ; Move to next letter
    jmp print_loop

done:
    ; Exit syscall
    mov eax, 1
    xor ebx, ebx
    int 0x80

; ========== PROCEDURE ==========
; prints character in cl, followed by newline
print_char:
    ; move char into memory
    mov [char], cl

    ; write char
    mov eax, 4          ; syscall: write
    mov ebx, 1          ; fd: stdout
    mov ecx, char       ; buffer
    mov edx, 1          ; count
    int 0x80

    ; write newline
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ret
