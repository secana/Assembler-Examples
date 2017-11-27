; Compare if two given strins are equal

format PE console
entry start
include 'win32a.inc'

section '.idata' import data readable writeable
    library kernel32, 'kernel32.dll', \
        msvcrt, 'MSVCRT.DLL'

    import kernel32, \
        ExitProcess, 'ExitProcess', \
        GetStdHandle, 'GetStdHandle', \
        ReadConsoleA , 'ReadConsoleA'

    import msvcrt, \
        printf, 'printf'

section '.data' data readable
    szEnterString db 'Please enter a string: ',0
    szEqual db 'The strings are equal',10,0
    szNotEqual db 'The string are not equal',10,0

section '.bss' data readable writeable
    strlen = 256
    szString1 db strlen dup 0
    szString2 db strlen dup 0
    dwReadBytes dd 0
    hStdin dd 0

section '.text' code readable executable
    start:
        push szEnterString
        call [printf]
        add esp, 4

        ; Get handle to stdin (console)
        push STD_INPUT_HANDLE
        call [GetStdHandle]
        mov [hStdin], eax

        ; Read string from console
        push 0                  ; Opt prameter. For ASCII always NULL
        push dwReadBytes        ; Number of bytes read
        push strlen - 1         ; Max num bytes to read
        push szString1          ; Address of buffer
        push [hStdin]           ; Handle to stdin
        call [ReadConsoleA]     ; ReadConsoleA -> Read string from stdin

        push szEnterString
        call [printf]
        add esp, 4

        push 0
        push dwReadBytes
        push strlen - 1
        push szString2
        push [hStdin]
        call [ReadConsoleA]

        mov edi, szString1  ; Address of string one
        mov esi, szString2  ; Address of string two
        mov ecx, strlen - 1 ; Length of string to compare
        cld                 ; Clear directory flag
        repe cmpsb          ; compare as long as equal -> repeat equal, compare string byte
        jecxz equal         ; jump exc zero

        push szNotEqual
        call [printf]
        add esp, 4

        jmp exit

    equal:
        push szEqual
        call [printf]
        add esp, 4

    exit:
        push 0
        call [ExitProcess]

