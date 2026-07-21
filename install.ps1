$ErrorActionPreference = "Stop"

$InstallDir = "$env:LOCALAPPDATA\ToG"

Write-Host ""
Write-Host "==================================="
Write-Host "      Installing ToG..."
Write-Host "==================================="
Write-Host ""

try {
    # Tạo thư mục cài đặt
    if (!(Test-Path $InstallDir)) {
        New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null
    }

    # Tải opentogs.bat
    Invoke-WebRequest `
        -Uri "https://raw.githubusercontent.com/ToG-keyz/ToGs/main/opentogs.bat" `
        -OutFile "$InstallDir\opentogs.bat"

    # Tải update.ps1
    Invoke-WebRequest `
        -Uri "https://raw.githubusercontent.com/ToG-keyz/ToGs/main/update.ps1" `
        -OutFile "$InstallDir\update.ps1"

    # Thêm vào PATH nếu chưa có
    $UserPath = [Environment]::GetEnvironmentVariable("Path", "User")

    if ($UserPath -notlike "*$InstallDir*") {
        [Environment]::SetEnvironmentVariable(
            "Path",
            "$UserPath;$InstallDir",
            "User"
        )
    }

    Write-Host ""
    Write-Host "==================================="
    Write-Host "  ToG installed successfully!"
    Write-Host "==================================="
    Write-Host ""
    Write-Host "Installation directory:"
    Write-Host "  $InstallDir"
    Write-Host ""
    Write-Host "Restart CMD or PowerShell, then run:"
    Write-Host ""
    Write-Host "    opentogs"
    Write-Host ""

}
catch {
    Write-Host ""
    Write-Host "==================================="
    Write-Host "  Installation failed!"
    Write-Host "==================================="
    Write-Host $_.Exception.Message
}
