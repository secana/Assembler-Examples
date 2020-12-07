format PE64 console
entry start
include 'win64a.inc'

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
    dwFirstNum rq 1
    dwSecondNum rq 1
    dwResult rq 1

section '.text' code readable executable
    start:

        ; Ask for the first number
        mov rcx, szEnterNum
        call [printf]

        mov rcx, szReadNumFormat
        mov rdx, dwFirstNum
        call [scanf]

        ; Ask for the second number
        mov rcx, szEnterNum
        call [printf]

        mov rcx, szReadNumFormat
        mov rdx, dwSecondNum
        call [scanf]

        ; Add both numbers
        mov rax, [dwFirstNum]
        mov rbx, [dwSecondNum]
        add rax, rbx
        mov [dwResult], rax

        ; Print the result
        mov rcx, szResult
        mov rdx, [dwFirstNum]
        mov r8, [dwSecondNum]
        mov r9, [dwResult]
        call [printf]

    exit:
        mov rcx, 0
        call [ExitProcess]