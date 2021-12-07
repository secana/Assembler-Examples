; x64 ELF executable
; Syscall-Table x64 https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/

format ELF64 executable 3

segment readable executable
entry start

start:

    mov     rax,1           ; sys_write
    mov     rdi,1           ; file descriptor (1 = stdout)
    mov     rsi,msg         ; message
    mov     rdx,msg_size    ; message size
    syscall

    mov     rax,60      ; sys_exit
    xor     rdi,rdi     ; error codde
    syscall

segment readable writeable

msg db 'Hello world!',0xA
msg_size = $-msg