format PE console
entry start
include 'win32a.inc'

section '.idata' import data readable writeable
    library kernel32, 'kernel32.dll', \
        msvcrt, 'MSVCRT.DLL'

    import kernel32, \
        ExitProcess, 'ExitProcess'

    import msvcrt, \
        printf, 'printf', \
        scanf, 'scanf'

section '.data' data readable
    szEnterNum db 'Please enter a number: ',0
    szResult db '%d + %d = %d',10,0
    szReadNumFormat db '%d',0

section '.bss' data readable writeable
    dwFirstNum rd 1
    dwSecondNum rd 1
    dwResult rd 1

section '.text' code readable executable
    start:

        ; Ask for the first number
        push szEnterNum
        call [printf]
        add esp, 4

        push dwFirstNum
        push szReadNumFormat
        call [scanf]
        add esp, 8

        ; Ask for the second number
        push szEnterNum
        call [printf]
        add esp, 4

        push dwSecondNum
        push szReadNumFormat
        call [scanf]
        add esp, 8

        ; Add both numbers
        mov eax, [dwFirstNum]
        mov ebx, [dwSecondNum]
        add eax, ebx
        mov [dwResult], eax

        ; Print the result
        push [dwResult]
        push [dwSecondNum]
        push [dwFirstNum]
        push szResult
        call [printf]
        add esp, 16

    exit:
        push 0
        call [ExitProcess]