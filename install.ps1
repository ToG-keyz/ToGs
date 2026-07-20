$InstallDir = "$env:LOCALAPPDATA\ToG"

Write-Host ""
Write-Host "==================================="
Write-Host "      Installing ToG..."
Write-Host "==================================="
Write-Host ""

# Tạo thư mục
New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null

# Tải opentog.bat
Invoke-WebRequest `
    -Uri "https://raw.githubusercontent.com/tog-keyz/tog-system/main/opentog.bat" `
    -OutFile "$InstallDir\opentog.bat"

# Tải update.ps1
Invoke-WebRequest `
    -Uri "https://raw.githubusercontent.com/tog-keyz/tog-system/main/update.ps1" `
    -OutFile "$InstallDir\update.ps1"

# Thêm PATH nếu chưa có
$UserPath = [Environment]::GetEnvironmentVariable("Path","User")

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
Write-Host "Restart CMD then type:"
Write-Host ""
Write-Host "    opentog"
Write-Host ""
