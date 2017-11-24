# Flat Assembler
Below you find a short description how the Flat Assembler (FASM) examples work.

## Install FASM
You can get FASM for Windows from here [FASM for Windows](https://flatassembler.net/fasmw172.zip).

To install FASM unpack the archive and put the folder somewhere on disk.
Add the path to the **FASM.exe** into your **PATH** environment variable.

Set the environment variable **INCLUDE** to the **INCLUDE** directory in the FASM folder. To do it temporary in PowerShell you can use for example `$env:INCLUDE = "C:\fasmw172\INCLUDE"`. The better solution would be to set the environment variable permanently.

## Compile the code
To compile an example just run `FASM.exe name_of_example.asm`. This creates an executable file which can be run.

