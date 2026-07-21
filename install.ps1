$ErrorActionPreference = "Stop"

$InstallDir = "$env:APPDATA\npm"

Write-Host ""
Write-Host "==================================="
Write-Host "      Installing ToG..."
Write-Host "==================================="
Write-Host ""

try {

    if (!(Test-Path $InstallDir)) {
        New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null
    }

    if (Test-Path "$InstallDir\opentog.bat") {
        Remove-Item "$InstallDir\opentog.bat" -Force
    }

    if (Test-Path "$InstallDir\update.ps1") {
        Remove-Item "$InstallDir\update.ps1" -Force
    }

    Invoke-WebRequest `
        -Uri "https://raw.githubusercontent.com/ToG-keyz/ToGs/main/opentog.bat" `
        -OutFile "$InstallDir\opentog.bat"

    Invoke-WebRequest `
        -Uri "https://raw.githubusercontent.com/ToG-keyz/ToGs/main/update.ps1" `
        -OutFile "$InstallDir\update.ps1"

    Write-Host ""
    Write-Host "==================================="
    Write-Host "  ToG installed successfully!"
    Write-Host "==================================="
    Write-Host ""
    Write-Host "Install Path:"
    Write-Host "  $InstallDir"
    Write-Host ""
    Write-Host "Open a new CMD and type:"
    Write-Host ""
    Write-Host "    opentog"
    Write-Host ""

}
catch {

    Write-Host ""
    Write-Host "==================================="
    Write-Host "  Installation failed!"
    Write-Host "==================================="
    Write-Host $_.Exception.Message

}
