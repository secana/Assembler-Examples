format PE console
entry start
include 'win32a.inc'

section '.idata' import data readable writable
    library kernel32, 'kernel32.dll', \
        msvcrt, 'MSVCRT.DLL'

    import kernel32, \
        ExitProcess, 'ExitProcess'

    import msvcrt, \
        printf, 'printf', \
        scanf, 'scanf'

section '.data' data readable
    szEnterOperand db 'Please enter operand {+, -, *, /}: ',0
    szEnterNum db 'Please enter a number: ', 0
    szNumFormat db '%d',0
    szOperandFormat db '%c',0
    szResultFormat db '%d %c %d = %d',0
    szResultDivFormat db '%d %c %d = %d, Remainder: %d',0
    szUnknownOperand db 'Unkown operand',0

section '.bss' data readable writable
    dbOperand rb 1
    ddNum1 rd 1
    ddNum2 rd 1
    ddResult rd 1
    ddRemainder rd 1

section '.text' code readable executable
    start:
        ; Ask to enter the operand
        push szEnterOperand
        call [printf]
        add esp, 4

        ; Read the operand from the console
        push dbOperand
        push szOperandFormat
        call [scanf]
        add esp, 8

        ; Ask for the first number
        push szEnterNum
        call [printf]
        add esp, 4

        ; Read first number from console
        push ddNum1
        push szNumFormat
        call [scanf]
        add esp, 8

        ; Ask for the second number
        push szEnterNum
        call [printf]
        add esp, 4

        ; Read second number from console
        push ddNum2
        push szNumFormat
        call [scanf]
        add esp, 8
        
        ; Jump to the correct operation
        cmp [dbOperand], '+'
        je operandAdd
        cmp [dbOperand], '-'
        je operandSub
        cmp [dbOperand], '*'
        je operandMul
        cmp [dbOperand], '/'
        je operandDiv
        
        ; Print if an unknown opertand was entered
        push szUnknownOperand
        call [printf]
        add esp, 4
        jmp exit

    operandDiv:
        mov eax, [ddNum1]
        cdq                 ; Convert sigend value in EAX in signed value in EDX:EAX
        mov ebx, [ddNum2]
        idiv ebx            ; Signed division divides 64 bit value EDX:EAX through the given operand
        mov [ddResult], eax
        mov [ddRemainder], edx
        jmp printResultRemainder

    operandMul:
        mov eax, [ddNum1]
        mov ebx, [ddNum2]
        imul eax, ebx
        mov [ddResult], eax
        jmp printResult

    operandSub:
        mov eax, [ddNum1]
        mov ebx, [ddNum2]
        sub eax, ebx
        mov [ddResult], eax
        jmp printResult

    operandAdd:
        mov eax, [ddNum1]
        mov ebx, [ddNum2]
        add eax, ebx
        mov [ddResult], eax
        jmp printResult

    
    printResult:
        movsx ecx, byte [dbOperand]
        push [ddResult]
        push [ddNum2]
        push ecx
        push [ddNum1]
        push szResultFormat
        call [printf]
        add esp, 20
        jmp exit

    printResultRemainder:
        movsx ecx, byte [dbOperand]
        push [ddRemainder]
        push [ddResult]
        push [ddNum2]
        push ecx
        push [ddNum1]
        push szResultDivFormat
        call [printf]
        add esp, 24

    exit:
        push 0
        call [ExitProcess]