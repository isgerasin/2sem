section .data
    
    Msg db "Congratulations, you've got super user rights", 0, 10
    LenMsg equ $ - Msg
    
    Error db "Sorry, password incorrect", 0, 10
    LenError equ $ - Error
    
    Invit db "Please, input password:", 10, 0
    LenInvit equ   $ - Invit 

    PasswordHash dw 0x109F

section .bss

section .text

global _start

_start:

    call ScanPassword
    sub rsp, 19
    mov rbx, rsp
    call HashSum
    call CmpHash
    
    ;exit (0)
    mov rax, 60
    mov rdi, 0
    syscall

;-----------------------------------------------------------
;Func doesn't gives super user rights
;Enter:no
;Exit:no
;Destr:rax, rdi, rsi, rdx
;------------------------------------------------------------
ErrorMsg:

    mov rax, 1
    mov rdi, 1
    mov rsi, Error
    mov rdx, LenError
    syscall
    
    ret
;-----------------------------------------------------------

;-----------------------------------------------------------
;Func gives super user rights
;Enter:no
;Exit:no
;Destr:rax, rdi, rsi, rdx
;------------------------------------------------------------
SupUserRt:

    mov rax, 1
    mov rdi, 1
    mov rsi, Msg
    mov rdx, LenMsg
    syscall
    
    ret
;-----------------------------------------------------------

;-----------------------------------------------------------
;Function comparies passwords and gives or not gives super 
;user rights
;Enter:rax - hash of string
;Exit: No
;Destr:
;-----------------------------------------------------------
CmpHash:

    cmp ax, word [PasswordHash]
    je .SupUser
    call ErrorMsg
    jmp .End

.SupUser:
    call SupUserRt

.End:
    ret
 
;-----------------------------------------------------------
;This hashFunc comparies input string specific number (hash)
;Enter:rbx - pointer on string in stack
;Exit:rax - hash
;Destr: r15
;-----------------------------------------------------------
HashSum:

    xor rax, rax
    xor r15, r15
    mov rcx, 9

.Next:
    cmp byte [rbx], 10
    je .End
    mov al, byte [rbx]
    mul rcx
    add r15, rax
    xor rax, rax
    inc rbx
    loop .Next

.End:
    mov rax, r15
    ret

;------------------------------------------------------------
;Scan string(password) from stdin and put her in stack
;Enter: non
;Exit:non
;Destr:rax, rdi, rsi, rdx
;-------------------------------------------------------------
ScanPassword:

    mov rax, 1
    mov rdi, 1
    mov rsi, Invit
    mov rdx, LenInvit
    syscall

    sub rsp, 11

    ;scanf ("%s", rsp)
    mov rax, 0
    mov rdi, 0
    mov rsi, rsp
    mov rdx, 19                     ;number 19 - a soft hint of stack overflow
    syscall

    add rsp, 11

    ret
;--------------------------------------------------------------



