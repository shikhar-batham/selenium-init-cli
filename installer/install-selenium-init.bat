@echo off
setlocal EnableDelayedExpansion

echo ================================
echo Installing Selenium Init CLI
echo ================================

REM 1. Check Java
java -version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Java not found. Please install Java 11+ first.
    exit /b 1
)

REM 2. Define paths
set INSTALL_HOME=%USERPROFILE%\.selenium-init
set BIN_DIR=%INSTALL_HOME%\bin
set JAR_NAME=selenium-init-1.0.0.jar

REM ⚠️ CHANGE THIS URL
set DOWNLOAD_URL=https://github.com/shikhar-batham/selenium-init-cli/releases/download/v1.0.0/%JAR_NAME%

REM 3. Create directories
if not exist "%BIN_DIR%" (
    mkdir "%BIN_DIR%"
)

REM 4. Create selenium-init.bat command
set CMD_FILE=%BIN_DIR%\selenium-init.bat

(
echo @echo off
echo java -jar "%INSTALL_HOME%\%JAR_NAME%" %%*
) > "%CMD_FILE%"

REM 5. Download JAR if not exists
if not exist "%INSTALL_HOME%\%JAR_NAME%" (
    echo Downloading Selenium Init CLI...
    powershell -Command "Invoke-WebRequest -Uri '%DOWNLOAD_URL%' -OutFile '%INSTALL_HOME%\%JAR_NAME%'"
)

REM 6. Add BIN_DIR to PATH (User level)
echo Adding Selenium Init to PATH...
setx PATH "%PATH%;%BIN_DIR%" >nul

echo.
echo ✅ Installation complete!
echo Restart your terminal and run:
echo selenium-init my-project
echo.
pause
