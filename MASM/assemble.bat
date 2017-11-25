@echo off
set MASM_PATH=C:\MASM32
set PATH=%PATH%;%MASM_PATH%\bin

if %1!==! goto noinputfile
goto assemble

:noinputfile
echo No input file specified
goto end


:assemble
ml /coff /I %MASM_PATH%\include %1 /link /LIBPATH:%MASM_PATH%\lib /SUBSYSTEM:CONSOLE
del *.lnk
del *.obj

:end
