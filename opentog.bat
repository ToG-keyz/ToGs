@echo off
chcp 65001 >nul
title TOG SYSTEM v2.0
color 0F
setlocal enabledelayedexpansion

:: ============================================
:: TOG SYSTEM - Main Program
:: ============================================

:header
cls
title TOG SYSTEM v2.0

:: Logo TOG
echo.
color 0B
echo     ███████╗██╗   ██╗███████╗████████╗███████╗███╗   ███╗
echo     ██╔════╝╚██╗ ██╔╝██╔════╝╚══██╔══╝██╔════╝████╗ ████║
color 0C
echo     ███████╗ ╚████╔╝ ███████╗   ██║   █████╗  ██╔████╔██║
echo     ╚════██║  ╚██╔╝  ╚════██║   ██║   ██╔══╝  ██║╚██╔╝██║
color 0B
echo     ███████║   ██║   ███████║   ██║   ███████╗██║ ╚═╝ ██║
echo     ╚══════╝   ╚═╝   ╚══════╝   ╚═╝   ╚══════╝╚═╝     ╚═╝
echo.
color 0C
echo     ████████╗ ██████╗  ██████╗ 
echo     ╚══██╔══╝██╔═══██╗██╔════╝ 
color 0B
echo        ██║   ██║   ██║██║  ███╗
echo        ██║   ██║   ██║██║   ██║
color 0C
echo        ██║   ╚██████╔╝╚██████╔╝
echo        ╚═╝    ╚═════╝  ╚═════╝ 
echo.

:: Khung menu
color 0E
echo  ╔══════════════════════════════════════════════════════════════════╗
color 0B
echo  ║                    TOG SYSTEM v2.0                              ║
color 0E
echo  ╠══════════════════════════════════════════════════════════════════╣
color 0A
echo  ║  help      - Show help menu                                     ║
echo  ║  version   - Show version information                           ║
color 0C
echo  ║  update    - Update TOG SYSTEM                                  ║
color 0A
echo  ║  cls       - Clear screen                                       ║
echo  ║  exit      - Exit TOG SYSTEM                                    ║
color 0E
echo  ╚══════════════════════════════════════════════════════════════════╝
echo.

:menu
set cmd=
color 0B
set /p cmd="TOG > "

if /I "!cmd!"=="help" goto help
if /I "!cmd!"=="version" goto version
if /I "!cmd!"=="update" goto update
if /I "!cmd!"=="cls" goto header
if /I "!cmd!"=="clear" goto header
if /I "!cmd!"=="exit" goto end
if /I "!cmd!"=="opentog" goto run_tog

if "!cmd!"=="" goto menu

:: Lệnh không hợp lệ
color 0C
echo.
echo  ╔══════════════════════════════════════════════════════════════════╗
echo  ║                    COMMAND ERROR                                ║
echo  ╠══════════════════════════════════════════════════════════════════╣
echo  ║  Unknown command: !cmd!                                         ║
echo  ║  Type "help" to see available commands.                        ║
echo  ╚══════════════════════════════════════════════════════════════════╝
color 0F
timeout /t 2 >nul
goto header

:run_tog
cls
color 0A
echo.
echo  ╔══════════════════════════════════════════════════════════════════╗
echo  ║                    RUNNING TOG                                  ║
echo  ╚══════════════════════════════════════════════════════════════════╝
echo.
if exist "%APPDATA%\npm\opentog.bat" (
    echo  [TOG] Starting TOG...
    timeout /t 1 >nul
    start "" "%APPDATA%\npm\opentog.bat"
    echo  [TOG] TOG started successfully!
) else (
    color 0C
    echo  [TOG] TOG not found at: %APPDATA%\npm\opentog.bat
    echo  [TOG] Please run update first.
)
echo.
pause
goto header

:help
cls
color 0E
echo.
echo  ╔══════════════════════════════════════════════════════════════════╗
echo  ║                    HELP MENU                                    ║
echo  ╠══════════════════════════════════════════════════════════════════╣
echo  ║                                                                  ║
color 0B
echo  ║  COMMANDS:                                                       ║
echo  ║                                                                  ║
echo  ║    help       - Show this help menu                              ║
echo  ║    version    - Show TOG version information                    ║
echo  ║    update     - Update TOG SYSTEM to latest version             ║
echo  ║    cls        - Clear screen                                    ║
echo  ║    clear      - Clear screen (alias)                            ║
echo  ║    exit       - Exit TOG SYSTEM                                 ║
echo  ║    opentog    - Run TOG from APPDATA                           ║
echo  ║                                                                  ║
color 0E
echo  ║  NOTES:                                                          ║
echo  ║                                                                  ║
color 0A
echo  ║    - Commands are case-insensitive                               ║
echo  ║    - Press UP arrow to see command history                      ║
echo  ║                                                                  ║
color 0E
echo  ╚══════════════════════════════════════════════════════════════════╝
echo.
pause
goto header

:version
cls
color 0B
echo.
echo  ╔══════════════════════════════════════════════════════════════════╗
echo  ║                    VERSION INFO                                 ║
echo  ╠══════════════════════════════════════════════════════════════════╣
echo  ║                                                                  ║
color 0C
echo  ║    ████████╗  ██████╗  ██████╗      ███████╗██╗   ██╗███████╗    ║
echo  ║    ╚══██╔══╝██╔═══██╗██╔════╝      ██╔════╝╚██╗ ██╔╝██╔════╝    ║
echo  ║       ██║   ██║   ██║██║  ███╗     ███████╗ ╚████╔╝ ███████╗    ║
echo  ║       ██║   ██║   ██║██║   ██║     ╚════██║  ╚██╔╝  ╚════██║    ║
echo  ║       ██║   ╚██████╔╝╚██████╔╝     ███████║   ██║   ███████║    ║
echo  ║       ╚═╝    ╚═════╝  ╚═════╝      ╚══════╝   ╚═╝   ╚══════╝    ║
echo  ║                                                                  ║
color 0B
echo  ║    Package: TOG SYSTEM                                           ║
echo  ║    Version: v2.0                                                ║
echo  ║    Author:  ToG                                                 ║
echo  ║    Release: %date%                                              ║
echo  ║    Path:    %APPDATA%\npm                                       ║
echo  ║                                                                  ║
color 0E
echo  ╚══════════════════════════════════════════════════════════════════╝
echo.
pause
goto header

:update
cls
color 0A
echo.
echo  ╔══════════════════════════════════════════════════════════════════╗
echo  ║                    UPDATING TOG                                 ║
echo  ╚══════════════════════════════════════════════════════════════════╝
echo.

:: Tạo thư mục nếu chưa có
if not exist "%APPDATA%\npm" (
    echo  [TOG] Creating directory: %APPDATA%\npm
    mkdir "%APPDATA%\npm" 2>nul
    echo  [TOG] Directory created!
    echo.
)

:: Tạo file update.ps1 mới
(
echo $ErrorActionPreference = "Stop"
echo $InstallDir = "$env:APPDATA\npm"
echo $TargetFile = Join-Path $InstallDir "opentog.bat"
echo $DownloadUrl = "https://raw.githubusercontent.com/ToG-keyz/ToGs/main/opentog.bat"
echo $BackupFile = Join-Path $InstallDir "opentog_backup.bat"
echo.
echo Write-Host ""
echo Write-Host "  [TOG] Downloading latest version..." -ForegroundColor Yellow
echo Write-Host ""
echo.
echo if (!(Test-Path $InstallDir)) {
echo     New-Item -ItemType Directory -Force -Path $InstallDir ^| Out-Null
echo }
echo.
echo if (Test-Path $TargetFile) {
echo     Copy-Item -Path $TargetFile -Destination $BackupFile -Force
echo }
echo.
echo try {
echo     Invoke-WebRequest -Uri $DownloadUrl -OutFile $TargetFile -UseBasicParsing
echo     if (Test-Path $TargetFile) {
echo         $FileSize = (Get-Item $TargetFile).Length
echo         $FileSizeKB = [math]::Round($FileSize / 1KB, 2)
echo         Write-Host ""
echo         Write-Host "  ╔════════════════════════════════════════════════════════╗" -ForegroundColor Green
echo         Write-Host "  ║              UPDATE SUCCESSFUL!                       ║" -ForegroundColor Green
echo         Write-Host "  ╚════════════════════════════════════════════════════════╝" -ForegroundColor Green
echo         Write-Host ""
echo         Write-Host "  [TOG] File: $TargetFile" -ForegroundColor Yellow
echo         Write-Host "  [TOG] Size: $FileSizeKB KB" -ForegroundColor Cyan
echo         Write-Host ""
echo         Write-Host "  [TOG] Please restart TOG to use the new version." -ForegroundColor Green
echo     }
echo } catch {
echo     Write-Host ""
echo     Write-Host "  ╔════════════════════════════════════════════════════════╗" -ForegroundColor Red
echo     Write-Host "  ║              UPDATE FAILED!                            ║" -ForegroundColor Red
echo     Write-Host "  ╚════════════════════════════════════════════════════════╝" -ForegroundColor Red
echo     Write-Host ""
echo     Write-Host "  [TOG] Error: $($_.Exception.Message)" -ForegroundColor Red
echo     if (Test-Path $BackupFile) {
echo         Copy-Item -Path $BackupFile -Destination $TargetFile -Force
echo         Write-Host "  [TOG] Backup restored!" -ForegroundColor Green
echo     }
echo }
) > "%APPDATA%\npm\update.ps1"

if exist "%APPDATA%\npm\update.ps1" (
    echo  [TOG] Running update script...
    timeout /t 1 >nul
    powershell -ExecutionPolicy Bypass -File "%APPDATA%\npm\update.ps1"
    echo.
    echo  [TOG] Update completed!
) else (
    color 0C
    echo.
    echo  ╔══════════════════════════════════════════════════════════════════╗
    echo  ║                    UPDATE ERROR                                 ║
    echo  ╠══════════════════════════════════════════════════════════════════╣
    echo  ║  Failed to create update script!                                ║
    echo  ║  Please check permissions or reinstall TOG.                    ║
    echo  ╚══════════════════════════════════════════════════════════════════╝
)

echo.
pause
goto header

:end
cls
color 0E
echo.
echo  ╔══════════════════════════════════════════════════════════════════╗
echo  ║                                                                  ║
echo  ║              THANKS FOR USING TOG SYSTEM                         ║
echo  ║                                                                  ║
echo  ║                   See you next time                             ║
echo  ║                                                                  ║
echo  ╚══════════════════════════════════════════════════════════════════╝
echo.
timeout /t 2 >nul
exit
