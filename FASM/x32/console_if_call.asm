; Check if a given number is smaller than 100

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
    szLower db '%d is lower than 100',10,0
    szGreaterOrEqual db '%d is greater or equal than 100',10,0
    szReadNumFormat db '%d',0

section '.bss' data readable writeable
    dwNumber rd 1

section '.text' code readable executable
    start:
        push szEnterNum
        call [printf]
        add esp, 4

        push dwNumber
        push szReadNumFormat
        call [scanf]
        add esp, 8

        cmp [dwNumber], 100
        jl lowerThanHundert

        push [dwNumber]
        push szGreaterOrEqual
        call [printf]
        add esp, 8
        jmp exit

    lowerThanHundert:

        push [dwNumber]
        push szLower
        call [printf]
        add esp, 8

    exit:
        push 0
        call [ExitProcess]