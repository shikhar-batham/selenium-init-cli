Write-Host "Installing Selenium Init CLI..."

# USER SAFE PATH (NO ADMIN)
$installHome = Join-Path $env:LOCALAPPDATA "SeleniumInit"
$binDir = Join-Path $installHome "bin"

$jarName = "selenium-init-1.0.0.jar"
$jarPath = Join-Path $installHome $jarName

$downloadUrl = "https://github.com/shikhar-batham/selenium-init-cli/releases/download/v1.0.0/$jarName"

# Create directories
New-Item -ItemType Directory -Force -Path $binDir | Out-Null

# Download JAR
if (!(Test-Path $jarPath)) {
    Write-Host "Downloading Selenium Init CLI..."
    Invoke-WebRequest -Uri $downloadUrl -OutFile $jarPath
}

# Create command
$cmdFile = Join-Path $binDir "selenium-init.cmd"
@"
@echo off
java -jar "$jarPath" %*
"@ | Out-File -Encoding ASCII $cmdFile

# Add to USER PATH
$userPath = [Environment]::GetEnvironmentVariable("PATH", "User")
if ($userPath -notlike "*$binDir*") {
    [Environment]::SetEnvironmentVariable(
            "PATH",
            "$userPath;$binDir",
            "User"
    )
}

Write-Host "Installation complete."
Write-Host "Restart terminal and run: selenium-init --help"
