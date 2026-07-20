@echo off
chcp 65001 >nul
color 0F
cls

:: Animation chữ TOG SYSTEM
echo.
echo  ═══════════════════════════════════════════════════════════════
echo   Loading TOG SYSTEM...
echo  ═══════════════════════════════════════════════════════════════

:: Animation loading
for /l %%i in (1,1,20) do (
    cls
    echo.
    echo  ═══════════════════════════════════════════════════════════════
    echo   Loading TOG SYSTEM... [█%random:~-2%%%]
    echo  ═══════════════════════════════════════════════════════════════
    timeout /t 0.05 >nul
)

cls
echo.
echo  ═══════════════════════════════════════════════════════════════
echo   [SYSTEM TOG - READY]
echo  ═══════════════════════════════════════════════════════════════
timeout /t 0.5 >nul

:: Màu xanh nước biển + đỏ
:header
cls
echo.
color 0B
echo     ███████╗██╗   ██╗███████╗████████╗███████╗███╗   ███╗
echo     ██╔════╝╚██╗ ██╔╝██╔════╝╚══██╔══╝██╔════╝████╗ ████║
echo     ███████╗ ╚████╔╝ ███████╗   ██║   █████╗  ██╔████╔██║
echo     ╚════██║  ╚██╔╝  ╚════██║   ██║   ██╔══╝  ██║╚██╔╝██║
echo     ███████║   ██║   ███████║   ██║   ███████╗██║ ╚═╝ ██║
echo     ╚══════╝   ╚═╝   ╚══════╝   ╚═╝   ╚══════╝╚═╝     ╚═╝
color 0C
echo.
echo     ████████╗ ██████╗  ██████╗ 
echo     ╚══██╔══╝██╔═══██╗██╔════╝ 
echo        ██║   ██║   ██║██║  ███╗
echo        ██║   ██║   ██║██║   ██║
echo        ██║   ╚██████╔╝╚██████╔╝
echo        ╚═╝    ╚═════╝  ╚═════╝ 
color 0B
echo.
echo     ╔═══════════════════════════════════════════════════════════════╗
echo     ║  TOG SYSTEM V1.0                                             ║
echo     ║  Type 'help' for commands                                   ║
echo     ║  Type 'exit' to quit                                        ║
echo     ║  Type 'update' to update                                    ║
echo     ╚═══════════════════════════════════════════════════════════════╝
color 0F
echo.

:menu
color 0B
set /p cmd="TOG ❯ "

if "%cmd%"=="exit" goto end
if "%cmd%"=="help" goto help
if "%cmd%"=="update" goto update

:: Tất cả lệnh khác đều bị từ chối
if "%cmd%"=="" goto menu
goto denied

:denied
color 0C
echo.
echo  ═══════════════════════════════════════════════════════════════
echo   [TOG] ⛔ COMMAND NOT AVAILABLE
echo   [TOG] Only 'help', 'update' and 'exit' are supported
echo  ═══════════════════════════════════════════════════════════════
color 0F
timeout /t 2 >nul
goto menu

:help
color 0E
echo.
echo  ═══════════════════════════════════════════════════════════════
echo   TOG SYSTEM - HELP
echo.
color 0B
echo    help             - Show this help
echo    update           - Update TOG SYSTEM
echo    exit             - Exit TOG SYSTEM
echo.
color 0E
echo    ⚠️  Only these commands are available
echo  ═══════════════════════════════════════════════════════════════
color 0F
goto menu

:update
color 0A
echo.
echo  ═══════════════════════════════════════════════════════════════
echo   [TOG] Updating TOG SYSTEM...
echo  ═══════════════════════════════════════════════════════════════
echo.

:: Tạo thư mục nếu chưa có
if not exist "%LOCALAPPDATA%\ToG" mkdir "%LOCALAPPDATA%\ToG"

:: Tạo file update.ps1
(
echo $url = "https://raw.githubusercontent.com/tog-keyz/tog-system/main/opentog.bat"
echo $tempFile = "$env:TEMP\opentog.bat"
echo Invoke-WebRequest -Uri $url -OutFile $tempFile
echo if (Test-Path $tempFile) {
echo     $targetPath = "$env:LOCALAPPDATA\ToG\opentog.bat"
echo     Copy-Item -Path $tempFile -Destination $targetPath -Force
echo     Write-Host "[TOG] ✅ Update completed!" -ForegroundColor Green
echo     Write-Host "[TOG] New version saved to: $targetPath" -ForegroundColor Yellow
echo     Remove-Item $tempFile -Force
echo } else {
echo     Write-Host "[TOG] ❌ Update failed!" -ForegroundColor Red
echo }
echo Start-Sleep -Seconds 2
) > "%LOCALAPPDATA%\ToG\update.ps1"

:: Chạy update script
powershell -ExecutionPolicy Bypass -File "%LOCALAPPDATA%\ToG\update.ps1"

color 0E
echo.
echo  ═══════════════════════════════════════════════════════════════
echo   [TOG] Update finished!
echo   [TOG] Restart TOG to use new version
echo  ═══════════════════════════════════════════════════════════════
color 0F
timeout /t 2 >nul
goto menu

:end
color 0E
echo.
echo  ═══════════════════════════════════════════════════════════════
echo  TOG SYSTEM - Goodbye! 👋
echo  ═══════════════════════════════════════════════════════════════
color 0F
timeout /t 1 >nul
exit
