; x32 ELF executable
; Syscall-Table x32 https://faculty.nps.edu/cseagle/assembly/sys_call.html

format ELF executable 3

segment readable executable
entry start    

start:

        mov     eax,4           ; sys_write
        mov     ebx,1           ; file descriptor (1 = stdout)
        mov     ecx,msg         ; message
        mov     edx,msg_size    ; message size
        int     0x80

        mov     eax,1       ; sys_exit
        xor     ebx,ebx     ; error code
        int     0x80

segment readable writeable

msg db 'Hello world!',0xA
msg_size = $-msg