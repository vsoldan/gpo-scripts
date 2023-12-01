REM --------------------------------------------------------------------------------------------
REM Script to install the settings of Logon Screen Image on Windows 10 Pro workstations
REM Author: Viorel Soldan
REM Date: 01.12.2023
REM Install: Add into GPO\Computer Configuration\Policies\Windows Settings\Scripts\Startup
REM --------------------------------------------------------------------------------------------
@echo off
REM Set the variables below
SET Win10Personalization="HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP"
SET Win10LogonIMG="C:\Company\LogonBackground.jpg"
REM --------------------------------------------------------------------------------------------
REM Do not edit below this point
REM --------------------------------------------------------------------------------------------
REM Check Windows version first
setlocal
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
if "%version%" == "11.0" goto InstWin11
if "%version%" == "10.0" goto InstWin10
endlocal

:InstWin10
REM Check if registry key exist and if not make the install
REG query %Win10Personalization% >nul
if %errorlevel% equ 0 (
      echo "[ COMPANY BRANDING ] Key already exist, exit peacefully"
      exit /b 0
    ) else (
      echo "[ COMPANY BRANDING ] Set the logon screen image registry settings"
      REG ADD %Win10Personalization%
      REG ADD %Win10Personalization% /v LockScreenImagePath /t REG_SZ /d "%Win10LogonIMG%" /f
      REG ADD %Win10Personalization% /v LockScreenImageUrl /t REG_SZ /d "%Win10LogonIMG%" /f
      REG ADD %Win10Personalization% /v LockScreenImageStatus /t REG_DWORD /d 1 /f
      exit /b 0
)

:InstWin11
REM Do nothing now
exit /b 0
