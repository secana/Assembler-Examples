# Flat Assembler
Below you find a short description how the Flat Assembler (FASM) examples work.

## Installing and Uninstalling FASM
Below you'll find information on how to install and uninstall FASM from your Windows machine.
### Install FASM 
You find a script **install_fasm.ps1** in this repository. Run the script in an elevated PowerShell terminal and follow the instructions. This will install FASM on you PC and add the needed environment variables to start working with FASM. 

Alternatively you can install FASM manually. See below for instructions.

### Uninstall FASM
You find a script **uninstall_fasm.ps1** in this repository. Run the script in an elevated PowerShell terminal to uninstall FASM automatically.

### Install FASM manually
You can get FASM for Windows from here [FASM for Windows](https://flatassembler.net/fasmw172.zip).

To install FASM unpack the archive and put the folder somewhere on disk.
Add the path to the **FASM.exe** into your **PATH** environment variable.

Set the environment variable **INCLUDE** to the **INCLUDE** directory in the FASM folder. To do it temporary in PowerShell you can use for example `$env:INCLUDE = "C:\fasmw172\INCLUDE"`. The better solution would be to set the environment variable permanently.

### Uninstall FASM manually
To uninstall FASM manually you have to reverse the steps from the manual installation above. First delete the folder containing FASM. Then delete the **INCLUDE** environment variable and remove the FASM path from the **PATH** environment variable.

## Compile the code
To compile an example just run `FASM.exe name_of_example.asm`. This creates an executable file which can be run.

