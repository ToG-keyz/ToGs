@echo off
chcp 65001 >nul
color 0F
title TOG SYSTEM
cls

echo.
echo  ═══════════════════════════════════════════════════════════════
echo   Loading TOG SYSTEM...
echo  ═══════════════════════════════════════════════════════════════

for /L %%i in (1,1,20) do (
    cls
    echo.
    echo  ═══════════════════════════════════════════════════════════════
    echo   Loading TOG SYSTEM... [%%i/20]
    echo  ═══════════════════════════════════════════════════════════════
    ping 127.0.0.1 -n 2 >nul
)

:header
cls
color 0B

echo.
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
echo     ╔══════════════════════════════════════════════════════════════╗
echo     ║                     TOG SYSTEM V1.0                         ║
echo     ║                                                            ║
echo     ║  help      Show help                                       ║
echo     ║  update    Update TOG                                      ║
echo     ║  exit      Exit                                            ║
echo     ╚══════════════════════════════════════════════════════════════╝

:menu
echo.
color 0F
set /p cmd=TOG ^>

if /I "%cmd%"=="help" goto help
if /I "%cmd%"=="update" goto update
if /I "%cmd%"=="exit" goto end

echo.
color 0C
echo [TOG] Command not found.
timeout /t 1 >nul
goto menu

:help
cls
echo.
echo ===============================
echo         TOG HELP
echo ===============================
echo.
echo help      Show help
echo update    Update TOG SYSTEM
echo exit      Exit TOG
echo.
pause
goto header

:update
cls
echo.
echo ===============================
echo      Updating TOG...
echo ===============================
echo.

if exist "%LOCALAPPDATA%\ToG\update.ps1" (
    powershell -ExecutionPolicy Bypass -File "%LOCALAPPDATA%\ToG\update.ps1"
) else (
    color 0C
    echo update.ps1 not found.
)

echo.
pause
goto header

:end
echo.
echo Goodbye!
timeout /t 1 >nul
exit
