; set environment variable "INCLUDE" to FASM INLCUDE folder.
; Example: $env:INCLUDE = "C:\fasmw172\INCLUDE"

; Windows x64 calling convention
; First four parameters go to rcx, rdx, r8, r9
; Additional parameters go on stack (right to left)
; 32 Bytes space have to be reserved on stack before the call and removed from stack after call

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
    szHelloWorld db 'Hello World',0

section '.code' code readable executable 
    start: 
        mov rcx, szHelloWorld
        sub rsp, 0x20
        call [printf]
        add rsp, 0x20
    

    exit:
        mov rcx, 0
        sub rsp, 0x20
        call [ExitProcess]
        add rsp, 0x20

