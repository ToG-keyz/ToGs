# Thiết lập thư mục cài đặt
$InstallDir = "$env:APPDATA\npm"

# Tạo thư mục nếu chưa tồn tại
if (!(Test-Path $InstallDir)) {
    New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null
}

# Kiểm tra và xóa file cũ nếu tồn tại
$TargetFile = "$InstallDir\opentog.bat"
if (Test-Path $TargetFile) {
    Write-Host "Removing old file: $TargetFile" -ForegroundColor Yellow
    Remove-Item -Path $TargetFile -Force
    Write-Host "Old file removed." -ForegroundColor Green
}

# Tải file mới
Write-Host "Downloading new version..." -ForegroundColor Cyan
try {
    Invoke-WebRequest `
        -Uri "https://raw.githubusercontent.com/ToG-keyz/ToGs/main/opentog.bat" `
        -OutFile $TargetFile `
        -UseBasicParsing
    
    # Kiểm tra file đã tải thành công
    if (Test-Path $TargetFile) {
        $FileSize = (Get-Item $TargetFile).Length
        Write-Host ""
        Write-Host "Update completed successfully!" -ForegroundColor Green
        Write-Host "File: $TargetFile" -ForegroundColor Yellow
        Write-Host "Size: $([math]::Round($FileSize / 1KB, 2)) KB" -ForegroundColor Cyan
    }
}
catch {
    Write-Host ""
    Write-Host "Update failed!" -ForegroundColor Red
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Read-Host "Press Enter to exit"
