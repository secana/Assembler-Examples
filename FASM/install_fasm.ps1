#requires -version 4.0
#requires -runasadministrator

$fasmURL = "https://flatassembler.net/fasmw172.zip"

function Get-DefaultInstallDir 
{
    if(${env:ProgramFiles(x86)} -eq $null)
    {
        $defInstallDir = $env:ProgramFiles
    }
    else 
    {
        $defInstallDir = ${env:ProgramFiles(x86)}    
    }

    return $defInstallDir
}

function Exit-InvalidChoise
{
    Write-Host "Invalid choise. Exit installation."
    exit 1
}

function Get-CustomInstallDir
{
    Write-Host "Please speficy the install directory: "
    $installDir = Read-Host
    if(Test-Path $installDir)
    {
        Write-Host "Going to use "$installDir" to install FASM"
    }
    else
    {
        Write-Host "Not a valid path: $installDir."
        exit 1
    }

    return $installDir
}

function Set-EnvironemtVariables ($Path)
{
    $oldEnvPath = [Environment]::GetEnvironmentVariable("PATH", "USER")
    $oldEnvPath += ";$Path"
    [Environment]::SetEnvironmentVariable("PATH", $oldEnvPath, "USER")

    if($env:INCLUDE -eq $null)
    {
        [Environment]::SetEnvironmentVariable("INCLUDE", "$Path\INCLUDE", "USER")
    }
    else 
    {
        $oldEnvInc = [Environment]::GetEnvironmentVariable("PATH", "USER")
        $oldEnvInc += ";$Path\INCLUDE"
        [Environment]::SetEnvironmentVariable("INCLUDE", "$Path\INCLUDE", "USER")
    }
}

function Install-FASM ($Path) {
    $tmpFasm = "$env:TEMP\fasm.zip"
    $destPath = "$Path\FASM"

    Invoke-WebRequest -Uri $fasmURL -OutFile $tmpFasm
    Microsoft.PowerShell.Archive\Expand-Archive -Path $tmpFasm -DestinationPath $destPath

    Set-EnvironemtVariables -Path $destPath

    Remove-Item $tmpFasm
}

$defInstallDir = Get-DefaultInstallDir
Write-Host "Install FASM to "$defInstallDir"? [y/n]"
$confirm = Read-Host

if($confirm -eq "y" )
{
    Install-FASM -Path $defInstallDir
}
elseif ($confirm -eq "n") {
    Write-Host "Would you like to specify another directory? [y/n]"
    $confirm2 = Read-Host
    
    if($confirm2 -eq "y")
    {
       $installDir = Get-CustomInstallDir
       Install-FASM -Path $installDir
    }
    elseif($confirm2 -eq "n")
    {
        Write-Host "No install directory specified. Abort installation."
        exit 1
    }
    else
    {
        Exit-InvalidChoise
    }
}
else
{
    Exit-InvalidChoise
}

Write-Host "Please restart PowerShell terminal to take effect."
exit 0