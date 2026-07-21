@echo off
chcp 65001 >nul
title TOG SYSTEM
color 0F
cls

:header
cls
title TOG SYSTEM v1.0

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

color 0B
echo     ╔══════════════════════════════════════════════════════════════╗

color 0C
echo     ║                     TOG SYSTEM v1.0                         ║

color 0B
echo     ╠══════════════════════════════════════════════════════════════╣
echo     ║  help      Show help                                        ║

color 0C
echo     ║  version   Show version                                     ║
echo     ║  update    Update TOG                                       ║

color 0B
echo     ║  cls       Clear screen                                     ║
echo     ║  exit      Exit                                             ║
echo     ╚══════════════════════════════════════════════════════════════╝

color 0F
echo.

:menu
set /p cmd=TOG ^>

if /I "%cmd%"=="help" goto help
if /I "%cmd%"=="version" goto version
if /I "%cmd%"=="update" goto update
if /I "%cmd%"=="cls" goto header
if /I "%cmd%"=="clear" goto header
if /I "%cmd%"=="exit" goto end

if "%cmd%"=="" goto menu

color 0C
echo.
echo ==========================================================
echo [TOG] Unknown command: %cmd%
echo [TOG] Type "help" to see available commands.
echo ==========================================================
color 0F
timeout /t 2 >nul
goto menu

:help
cls
color 0E

echo.
echo ====================== TOG HELP ======================
echo.
echo help       Show this help menu
echo version    Show TOG version
echo update     Update TOG SYSTEM
echo cls        Clear screen
echo clear      Clear screen
echo exit       Exit TOG
echo.
echo Installation Path:
echo %APPDATA%\npm
echo.
echo Executable:
echo opentog
echo.
echo ======================================================

pause
goto header

:version
cls
color 0B

echo.
echo ==========================================
echo              TOG SYSTEM
echo ==========================================
echo.
echo Version : v1.0
echo Author  : ToG
echo.
echo Install Path:
echo %APPDATA%\npm
echo.
echo ==========================================

pause
goto header

:update
cls
color 0A

echo.
echo ==========================================
echo        Updating TOG SYSTEM...
echo ==========================================
echo.

if exist "%APPDATA%\npm\update.ps1" (
    powershell -ExecutionPolicy Bypass -File "%APPDATA%\npm\update.ps1"
) else (
    color 0C
    echo.
    echo update.ps1 not found!
    echo Please reinstall TOG.
    pause
    goto header
)

echo.
echo ==========================================
echo Update completed successfully.
echo Restart TOG to use the new version.
echo ==========================================

timeout /t 2 >nul
exit

:end
cls
color 0E

echo.
echo ==========================================
echo      Thanks for using TOG SYSTEM!
echo ==========================================

timeout /t 1 >nul
exit
