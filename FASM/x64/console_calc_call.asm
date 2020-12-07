format PE64 console
entry start
include 'win64a.inc'

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
    szResultFormat db '%d %c %d = %d',10,0
    szResultDivFormat db '%d %c %d = %d, Remainder: %d',10,0
    szUnknownOperand db 'Unkown operand',0

section '.bss' data readable writable
    dbOperand rq 1
    ddNum1 rq 1
    ddNum2 rq 1
    ddResult rq 1
    ddRemainder rq 1

section '.text' code readable executable
    start:
        ; Ask to enter the operand
        mov rcx, szEnterOperand
        call [printf]

        ; Read the operand from the console
        mov rcx, szOperandFormat
        mov rdx, dbOperand
        call [scanf]

        ; Ask for the first number
        mov rcx, szEnterNum
        call [printf]

        ; Read first number from console
        mov rcx, szNumFormat
        mov rdx, ddNum1
        call [scanf]

        ; Ask for the second number
        mov rcx, szEnterNum
        call [printf]

        ; Read second number from console
        mov rcx, szNumFormat
        mov rdx, ddNum2
        call [scanf]
        
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
        mov rcx, szUnknownOperand
        call [printf]
        jmp exit

    operandDiv:
        mov rax, [ddNum1]
        cdq                 ; Convert sigend value in EAX in signed value in EDX:EAX
        mov rbx, [ddNum2]
        idiv rbx            ; Signed division divides 64 bit value EDX:EAX through the given operand
        mov [ddResult], rax
        mov [ddRemainder], rdx
        jmp printResultRemainder

    operandMul:
        mov rax, [ddNum1]
        mov rbx, [ddNum2]
        imul rax, rbx
        mov [ddResult], rax
        jmp printResult

    operandSub:
        mov rax, [ddNum1]
        mov rbx, [ddNum2]
        sub rax, rbx
        mov [ddResult], rax
        jmp printResult

    operandAdd:
        mov rax, [ddNum1]
        mov rbx, [ddNum2]
        add rax, rbx
        mov [ddResult], rax
        jmp printResult

    
    printResult:
        mov rcx, szResultFormat
        mov rdx, [ddNum1]
        movsx r8, byte [dbOperand]
        mov r9, [ddNum2]
        push [ddResult]
        sub rsp, 32
        call [printf]
        add rsp, 40
        jmp exit

    printResultRemainder:
        
        mov rcx, szResultDivFormat
        mov rdx, [ddNum1]
        movsx r8, byte [dbOperand]
        mov r9, [ddNum2]
        push [ddRemainder]
        push [ddResult]
        sub rsp, 32
        call [printf]
        add rsp, 48

    exit:
        mov rcx, 0
        call [ExitProcess]