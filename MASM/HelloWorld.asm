; Assemble.bat HelloWorldConsole.asm

; general options
.386                ; CPU architecture
.model flat,stdcall  ; Use stdcall calling convention
option casemap:none ; Be case sensitive

; Inlcude header
include \masm32\include\windows.inc
include \masm32\include\masm32.inc
include \masm32\include\kernel32.inc

; Include libraries
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

; Data section
.data
szText db "Hello World",10,0  ; 10 = LF, 0 = Zero terminated string (sz)

; Code section
.code
start:
  push offset szText
  call StdOut
  push 0
  call ExitProcess
end start
