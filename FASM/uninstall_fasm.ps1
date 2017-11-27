#requires -version 4.0
#requires -runasadministrator

$fasmDir = Split-Path -Parent $env:INCLUDE

Write-Host "Remove FASM directory at" $fasmDir
Remove-Item -Recurse -Force $fasmDir

Write-Host "Remove INCLUDE environment variable"
[Environment]::SetEnvironmentVariable("INCLUDE", $null, "User")

Write-Host "Remove FASM from PATH environment variable"

$path = [Environment]::GetEnvironmentVariable('Path', 'User')
$path = ($path.Split(';') | Where-Object { $_ -ne '$fasmDir' }) -join ';'

[Environment]::SetEnvironmentVariable('Path', $path, 'User')

Write-Host "Uninstalled FASM"
exit 1
