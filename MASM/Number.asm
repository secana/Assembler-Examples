;==============================================================
  .386
  .model flat,stdcall
  option casemap:none
;==============================================================

 include \masm32\include\windows.inc
 include \masm32\include\masm32.inc
 include \masm32\include\kernel32.inc

 includelib \masm32\lib\kernel32.lib
 includelib \masm32\lib\masm32.lib

.data
 szLine db 80 DUP("="),0
 szCaption db "My first console program:",10,0
 szInput db "Please enter a number:",0
 szOutput db "Your number is:",0
 number      db 20 DUP(0)
.code

start:
 push offset szLine
 call StdOut
 push offset szCaption
 call StdOut
 push offset szLine
 call StdOut
 push offset szInput
 call StdOut
 push 20
 push offset number
 call StdIn
 push offset szOutput
 call StdOut
 push offset number
 call StdOut

 push 0
 call ExitProcess
end start
