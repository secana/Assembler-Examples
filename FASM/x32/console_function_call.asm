format PE console
entry start
include 'win32a.inc'

section '.idata' import data readable writeable
    library kernel32, 'kernel32.dll', \
        msvcrt, 'MSVCRT.DLL'

    import kernel32, \
        ExitProcess, 'ExitProcess'

    import msvcrt, \
        printf, 'printf'

section '.data' data readable
    szFormat db 'My function was called with %d and %d',10,0
    szReturnFormat db 'My function returned %d',10,0
    

section '.text' code readable executable

    myFunc: 
        ; Prolog
        push ebp
        mov ebp, esp
        sub esp, 4      ; Space for one local variables

        mov eax, szFormat
        mov [ebp-4], eax ; move value in local var
        
        cinvoke printf, [ebp-4], [ebp+8], [ebp+0xC] ; Print which parameters the function got

        mov eax, [ebp+8]
        mov ebx, [ebp+0xC]
        add eax, ebx

        ; Epilog
        mov esp, ebp
        pop ebp
        ret

    start:
        ; Call myFunc with paremeters (5,7)
        push 7
        push 5
        call myFunc
        add esp, 8

        cinvoke printf, szReturnFormat, eax

    exit:
        push 0
        call [ExitProcess]