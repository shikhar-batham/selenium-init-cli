# uninstall.ps1
$ErrorActionPreference = "Stop"

$installDir = "$env:ProgramFiles\SeleniumInit"
$binDir = "$installDir\bin"

# Remove folder
if (Test-Path $installDir) {
    Remove-Item -Recurse -Force $installDir
}

# Remove PATH entry
$envPath = [Environment]::GetEnvironmentVariable("PATH", "Machine")
$newPath = ($envPath -split ";" | Where-Object { $_ -ne $binDir }) -join ";"
[Environment]::SetEnvironmentVariable("PATH", $newPath, "Machine")

Write-Host "Selenium Init CLI uninstalled."
exit 0
