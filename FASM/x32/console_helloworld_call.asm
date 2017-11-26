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
    szHelloWorld db 'Hello World',10,0

section '.text' code readable executable
    start:
        push szHelloWorld
        call [printf]
        add esp, 4
    
    exit:
        push 0
        call [ExitProcess]