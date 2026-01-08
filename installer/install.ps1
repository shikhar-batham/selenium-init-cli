Write-Host "Installing Selenium Init CLI..."

# 1. Paths (USER SAFE)
$installHome = "$env:LOCALAPPDATA\SeleniumInit"
$binDir = "$installHome\bin"
$jarName = "selenium-init-1.0.0.jar"
$jarPath = "$installHome\$jarName"

$downloadUrl = "https://github.com/shikhar-batham/selenium-init-cli/releases/download/v1.0.0/$jarName"

# 2. Create directories
New-Item -ItemType Directory -Force -Path $binDir | Out-Null

# 3. Download JAR
if (!(Test-Path $jarPath)) {
    Write-Host "Downloading JAR..."
    Invoke-WebRequest -Uri $downloadUrl -OutFile $jarPath
}

# 4. Create CLI command
$cmdFile = "$binDir\selenium-init.cmd"
@"
@echo off
java -jar "$jarPath" %*
"@ | Out-File -Encoding ASCII $cmdFile

# 5. Add to USER PATH (only once)
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
