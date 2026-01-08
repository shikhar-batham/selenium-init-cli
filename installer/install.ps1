# install.ps1
$ErrorActionPreference = "Stop"

Write-Host "Installing Selenium Init CLI..."

$installDir = "$env:ProgramFiles\SeleniumInit"
$binDir = "$installDir\bin"

# Create directories
New-Item -ItemType Directory -Force -Path $binDir | Out-Null

# Download main script
$cliUrl = "https://raw.githubusercontent.com/shikhar-batham/selenium-init-cli/main/selenium-init.ps1"
$cliPath = "$binDir\selenium-init.ps1"

Invoke-WebRequest $cliUrl -OutFile $cliPath -UseBasicParsing

# Create CMD shim
$cmdShim = "$binDir\selenium-init.cmd"
@"
@echo off
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0selenium-init.ps1" %*
"@ | Set-Content -Encoding ASCII $cmdShim

# Add to PATH
$envPath = [Environment]::GetEnvironmentVariable("PATH", "Machine")
if ($envPath -notlike "*$binDir*") {
    [Environment]::SetEnvironmentVariable(
        "PATH",
        "$envPath;$binDir",
        "Machine"
    )
}

Write-Host "Selenium Init CLI installed successfully."
exit 0
