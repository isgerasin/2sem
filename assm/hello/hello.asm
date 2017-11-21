section     .text
global      _start                              ;must be declared for linker (ld)
 
_start:                                         ;tell linker entry point
 
    mov     edx,len                             ;message length
    mov     ecx,msg                             ;message to write
    mov     ebx,1                               ;file descriptor (stdout)
    mov     eax,4                               ;system call number (sys_write)
    int     21h                               ;call kernel

    mov     eax,1                               ;system call number (sys_exit)
    int     80h                                ;call kernel
 
section     .data
 
msg     db  'Hello, $world!',0ah                 ;our dear string
len     equ $ - msg                             ;length of our dear string
