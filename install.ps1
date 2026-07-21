$ErrorActionPreference = "Stop"

$InstallDir = "$env:APPDATA\npm"

Write-Host ""
Write-Host "============================================================"
Write-Host "              Installing ToG SYSTEM"
Write-Host "============================================================"
Write-Host ""

try {
    # Tạo thư mục nếu chưa có
    if (!(Test-Path $InstallDir)) {
        Write-Host "[TOG] Creating directory: $InstallDir" -ForegroundColor Yellow
        New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null
        Write-Host "[TOG] Directory created!" -ForegroundColor Green
        Write-Host ""
    }

    # === XÓA TẤT CẢ FILE TRÙNG TÊN ===
    Write-Host "[TOG] Searching for duplicate files..." -ForegroundColor Yellow
    
    # Xóa trong thư mục chính
    $FilesToRemove = @(
        "opentog.bat",
        "opentog_backup.bat",
        "update.ps1",
        "update_backup.ps1",
        "tog.bat",
        "tog_old.bat"
    )
    
    foreach ($File in $FilesToRemove) {
        $FilePath = Join-Path $InstallDir $File
        if (Test-Path $FilePath) {
            Write-Host "[TOG] Removing: $File" -ForegroundColor Cyan
            Remove-Item -Path $FilePath -Force
            Write-Host "[TOG] Removed: $File" -ForegroundColor Green
        }
    }
    
    # Xóa trong tất cả thư mục con (nếu có)
    Write-Host "[TOG] Scanning subdirectories..." -ForegroundColor Yellow
    $SubDirs = Get-ChildItem -Path $InstallDir -Directory -ErrorAction SilentlyContinue
    foreach ($Dir in $SubDirs) {
        $SubFiles = Get-ChildItem -Path $Dir.FullName -Filter "*.bat" -ErrorAction SilentlyContinue
        foreach ($SubFile in $SubFiles) {
            if ($SubFile.Name -match "opentog|update|tog") {
                Write-Host "[TOG] Removing: $($SubFile.FullName)" -ForegroundColor Cyan
                Remove-Item -Path $SubFile.FullName -Force
                Write-Host "[TOG] Removed: $($SubFile.Name)" -ForegroundColor Green
            }
        }
    }
    
    Write-Host "[TOG] Cleanup completed!" -ForegroundColor Green
    Write-Host ""

    # === TẢI FILE MỚI ===
    Write-Host "[TOG] Downloading files..." -ForegroundColor Yellow
    
    # Tải opentog.bat
    Write-Host "[TOG] Downloading: opentog.bat" -ForegroundColor Cyan
    Invoke-WebRequest `
        -Uri "https://raw.githubusercontent.com/ToG-keyz/ToGs/main/opentog.bat" `
        -OutFile "$InstallDir\opentog.bat" `
        -UseBasicParsing
    
    # Tải update.ps1
    Write-Host "[TOG] Downloading: update.ps1" -ForegroundColor Cyan
    Invoke-WebRequest `
        -Uri "https://raw.githubusercontent.com/ToG-keyz/ToGs/main/update.ps1" `
        -OutFile "$InstallDir\update.ps1" `
        -UseBasicParsing

    # === KIỂM TRA FILE ĐÃ TẢI ===
    Write-Host ""
    Write-Host "[TOG] Verifying files..." -ForegroundColor Yellow
    
    $File1 = "$InstallDir\opentog.bat"
    $File2 = "$InstallDir\update.ps1"
    
    if ((Test-Path $File1) -and (Test-Path $File2)) {
        $Size1 = [math]::Round((Get-Item $File1).Length / 1KB, 2)
        $Size2 = [math]::Round((Get-Item $File2).Length / 1KB, 2)
        
        Write-Host ""
        Write-Host "============================================================" -ForegroundColor Green
        Write-Host "        ✅ ToG INSTALLED SUCCESSFULLY!                      " -ForegroundColor Green
        Write-Host "============================================================" -ForegroundColor Green
        Write-Host ""
        Write-Host "  📁 Install Path:" -ForegroundColor Yellow
        Write-Host "     $InstallDir" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "  📄 Files installed:" -ForegroundColor Yellow
        Write-Host "     opentog.bat  ($Size1 KB)" -ForegroundColor Cyan
        Write-Host "     update.ps1   ($Size2 KB)" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "  🚀 To run ToG, open a new CMD and type:" -ForegroundColor Yellow
        Write-Host "     opentog" -ForegroundColor Green
        Write-Host ""
        Write-Host "  🔄 To update ToG, type:" -ForegroundColor Yellow
        Write-Host "     update" -ForegroundColor Green
        Write-Host ""
    } else {
        throw "One or more files failed to download!"
    }

}
catch {
    Write-Host ""
    Write-Host "============================================================" -ForegroundColor Red
    Write-Host "        ❌ INSTALLATION FAILED!                              " -ForegroundColor Red
    Write-Host "============================================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "  Error Details:" -ForegroundColor Yellow
    Write-Host "  $($_.Exception.Message)" -ForegroundColor Red
    Write-Host ""
    Write-Host "  Possible solutions:" -ForegroundColor Yellow
    Write-Host "  1. Check your internet connection" -ForegroundColor Cyan
    Write-Host "  2. Run PowerShell as Administrator" -ForegroundColor Cyan
    Write-Host "  3. Check if the URL is correct" -ForegroundColor Cyan
    Write-Host "  4. Disable antivirus temporarily" -ForegroundColor Cyan
    Write-Host ""
}

Write-Host ""
Read-Host "Press Enter to exit"
