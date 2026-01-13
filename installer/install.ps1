$ErrorActionPreference = "Stop"

$installRoot = Join-Path $env:LOCALAPPDATA "SeleniumInit"
$binDir = Join-Path $installRoot "bin"
$jarName = "selenium-init-1.0.0.jar"
$jarPath = Join-Path $installRoot $jarName
$cmdPath = Join-Path $binDir "selenium-init.cmd"

$downloadUrl = "https://github.com/shikhar-batham/selenium-init-cli/releases/download/v1.0.0/$jarName"

# Create dirs
New-Item -ItemType Directory -Force -Path $binDir | Out-Null

# Download jar
if (-not (Test-Path $jarPath)) {
    Invoke-WebRequest -Uri $downloadUrl -OutFile $jarPath
}

# Create cmd wrapper
"@echo off`r`njava -jar `"$jarPath`" %*" | Set-Content -Encoding ASCII $cmdPath

# Add PATH only if not winget
if (-not $env:WINGET_INSTALLER_CONTEXT) {
    $userPath = [Environment]::GetEnvironmentVariable("PATH", "User")
    if ($userPath -notlike "*$binDir*") {
        [Environment]::SetEnvironmentVariable(
                "PATH",
                "$userPath;$binDir",
                "User"
        )
    }
}

exit 0
