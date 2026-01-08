Write-Host "Installing Selenium Init CLI..."

# -------- Paths (USER-SAFE) --------
$installRoot = "$env:LOCALAPPDATA\Programs\SeleniumInit"
$binDir = "$installRoot\bin"
$jarName = "selenium-init-1.0.0.jar"

$downloadUrl = "https://github.com/shikhar-batham/selenium-init-cli/releases/download/v1.0.0/$jarName"

# -------- Create dirs --------
New-Item -ItemType Directory -Force -Path $binDir | Out-Null

# -------- Download JAR --------
$jarPath = "$installRoot\$jarName"
if (-not (Test-Path $jarPath)) {
    Invoke-WebRequest -Uri $downloadUrl -OutFile $jarPath -UseBasicParsing
}

# -------- Create CMD shim --------
$cmdPath = "$binDir\selenium-init.cmd"

@"
@echo off
java -jar "$jarPath" %*
"@ | Set-Content -Encoding ASCII $cmdPath

# -------- Add to USER PATH (silent-safe) --------
$existingPath = [Environment]::GetEnvironmentVariable("Path", "User")

if ($existingPath -notlike "*$binDir*") {
    [Environment]::SetEnvironmentVariable(
            "Path",
            "$existingPath;$binDir",
            "User"
    )
}

Write-Host "Selenium Init CLI installed successfully."
Write-Host "Restart terminal to use: selenium-init"
exit 0
