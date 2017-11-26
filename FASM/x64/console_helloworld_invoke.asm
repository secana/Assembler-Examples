format PE64 console 
entry start 
include 'win64a.inc' 

section '.idata' import data readable writeable 
    library kernel32,'kernel32.dll', \
        msvcrt, 'MSVCRT.DLL'

    import kernel32,\ 
        ExitProcess, 'ExitProcess'

    import msvcrt, \
        printf, 'printf'


section '.data' data readable
    szHelloWorld db 'Hello World',10,0

section '.text' code readable executable 
    start: 
        mov rax, szHelloWorld
        cinvoke printf, rax

    exit:
        invoke	ExitProcess, 0

