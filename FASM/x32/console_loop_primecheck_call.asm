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
    szNumFormat db '%d',0
    szPrime db '%d is prime',0
    szNotPrime db '%d is not prime',0

section '.bss' data readable writeable
    ddNum rd 1
    ddSqrt rd 1

section '.text' code readable executable
    start:
        push szEnterNum
        call [printf]
        add esp, 4

        push ddNum
        push szNumFormat
        call [scanf]
        add esp, 8

        ; Handle special cases "1", "2", "3"
        cmp [ddNum], 1
        je notPrime
        cmp [ddNum], 2
        je isPrime
        cmp [ddNum], 3
        je isPrime

        ; Check if number is even
        clc                 ; Clear the carry flag
        mov ebx, [ddNum]
        shr ebx, 1
        jb checkIfPrime     ; Jump if carry flag is set -> number is odd
        jmp notPrime        ; Number is even -> not a prime

    checkIfPrime:
        fild [ddNum]     ; Integer LoaD from memory -> int to float
        fsqrt            ; Compute sqrt of value in ST(0) and store result in ST(0)
        fist [ddSqrt]    ; Store integer number to memory
        
        mov ebx, 3
        loopPrime:
            mov eax, [ddNum]
            cdq                 ; Convert signed value in EAX in signed value in EDX:EAX
            idiv ebx            ; Signed division divides 64 bit value in EDX:EAX through the given operand. Result in EAX, remainder in EDX
            cmp edx, 0          ; Check if the remainder is 0
            je notPrime         ; Not a prime if the remainder is 0
            cmp ebx, [ddSqrt]   
            jg isPrime          ; If ebx is bigger than the sqrt, stop the loop. The number is prime,
            inc ebx
            jmp loopPrime

    notPrime:
        push [ddNum]
        push szNotPrime
        call [printf]
        add esp, 8
        jmp exit

    isPrime: 
        push [ddNum]
        push szPrime
        call [printf]
        add esp, 8

    exit: 
        push 0
        call [ExitProcess]

    