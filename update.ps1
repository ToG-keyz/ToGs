$ErrorActionPreference = "Stop"

$InstallDir = "$env:LOCALAPPDATA\ToG"
$TargetFile = Join-Path $InstallDir "opentog.bat"
$DownloadUrl = "https://raw.githubusercontent.com/ToG-keyz/ToGs/main/opentogs.bat"

Write-Host ""
Write-Host "========================================="
Write-Host "        Updating TOG SYSTEM..."
Write-Host "========================================="
Write-Host ""

# Tạo thư mục nếu chưa có
if (!(Test-Path $InstallDir)) {
    New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null
}

try {

    Invoke-WebRequest `
        -Uri $DownloadUrl `
        -OutFile $TargetFile `
        -UseBasicParsing

    Write-Host ""
    Write-Host "[TOG] Update completed successfully!" -ForegroundColor Green
    Write-Host "[TOG] File: $TargetFile" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Please restart ToG to use the new version." -ForegroundColor Cyan

}
catch {

    Write-Host ""
    Write-Host "[TOG] Update failed!" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red

}

Write-Host ""
Pause
