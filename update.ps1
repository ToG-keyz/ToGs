$ErrorActionPreference = "Stop"

# Cấu hình màu sắc
$ColorRed = "Red"
$ColorGreen = "Green"
$ColorYellow = "Yellow"
$ColorCyan = "Cyan"
$ColorMagenta = "Magenta"

$InstallDir = "$env:LOCALAPPDATA\ToG"
$TargetFile = Join-Path $InstallDir "opentog.bat"
$DownloadUrl = "https://raw.githubusercontent.com/ToG-keyz/ToGs/main/opentogs.bat"
$BackupFile = Join-Path $InstallDir "opentog_backup.bat"

Clear-Host

# Header
Write-Host ""
Write-Host "╔══════════════════════════════════════════════════════════════╗" -ForegroundColor $ColorMagenta
Write-Host "║                    TOG SYSTEM UPDATER                        ║" -ForegroundColor $ColorMagenta
Write-Host "╚══════════════════════════════════════════════════════════════╝" -ForegroundColor $ColorMagenta
Write-Host ""

# Animation loading
Write-Host "Checking for updates..." -ForegroundColor $ColorYellow
Write-Host ""
for ($i = 0; $i -le 100; $i += 10) {
    $percent = $i
    $bar = "█" * ($i / 5) + "░" * ((100 - $i) / 5)
    Write-Host "`r[$bar] $percent%  " -ForegroundColor $ColorCyan -NoNewline
    Start-Sleep -Milliseconds 100
}
Write-Host ""

# Tạo thư mục nếu chưa có
if (!(Test-Path $InstallDir)) {
    Write-Host ""
    Write-Host "[TOG] Creating directory: $InstallDir" -ForegroundColor $ColorYellow
    New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null
    Write-Host "[TOG] ✅ Directory created!" -ForegroundColor $ColorGreen
}

# Backup file cũ nếu tồn tại
if (Test-Path $TargetFile) {
    Write-Host ""
    Write-Host "[TOG] Creating backup..." -ForegroundColor $ColorYellow
    Copy-Item -Path $TargetFile -Destination $BackupFile -Force
    Write-Host "[TOG] ✅ Backup created: $BackupFile" -ForegroundColor $ColorGreen
}

Write-Host ""
Write-Host "[TOG] Downloading new version..." -ForegroundColor $ColorYellow

try {
    # Download với progress bar
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($DownloadUrl, $TargetFile)
    
    # Kiểm tra file đã tải về
    if (Test-Path $TargetFile) {
        $FileSize = (Get-Item $TargetFile).Length
        $FileSizeKB = [math]::Round($FileSize / 1KB, 2)
        
        Write-Host ""
        Write-Host "╔══════════════════════════════════════════════════════════════╗" -ForegroundColor $ColorGreen
        Write-Host "║                    UPDATE SUCCESSFUL!                       ║" -ForegroundColor $ColorGreen
        Write-Host "╚══════════════════════════════════════════════════════════════╝" -ForegroundColor $ColorGreen
        Write-Host ""
        Write-Host "[TOG] ✅ File downloaded successfully!" -ForegroundColor $ColorGreen
        Write-Host "[TOG] 📁 Location: $TargetFile" -ForegroundColor $ColorYellow
        Write-Host "[TOG] 📊 Size: $FileSizeKB KB" -ForegroundColor $ColorCyan
        Write-Host ""
        Write-Host "[TOG] 🔄 Version: $(Get-Date -Format 'yyyy.MM.dd.HHmm')" -ForegroundColor $ColorMagenta
        Write-Host ""
        Write-Host "[TOG] Please restart ToG to use the new version." -ForegroundColor $ColorCyan
        Write-Host ""
        
        # Tự động mở file mới
        $choice = Read-Host "Do you want to open the new version now? (Y/N)"
        if ($choice -eq "Y" -or $choice -eq "y") {
            Start-Process $TargetFile
            Write-Host "[TOG] Opening new version..." -ForegroundColor $ColorGreen
        }
    }
    else {
        throw "Downloaded file not found!"
    }
}
catch {
    Write-Host ""
    Write-Host "╔══════════════════════════════════════════════════════════════╗" -ForegroundColor $ColorRed
    Write-Host "║                    UPDATE FAILED!                            ║" -ForegroundColor $ColorRed
    Write-Host "╚══════════════════════════════════════════════════════════════╝" -ForegroundColor $ColorRed
    Write-Host ""
    Write-Host "[TOG] ❌ Error details:" -ForegroundColor $ColorRed
    Write-Host "[TOG] $($_.Exception.Message)" -ForegroundColor $ColorRed
    
    # Khôi phục backup nếu có
    if (Test-Path $BackupFile) {
        Write-Host ""
        Write-Host "[TOG] Restoring backup..." -ForegroundColor $ColorYellow
        Copy-Item -Path $BackupFile -Destination $TargetFile -Force
        Write-Host "[TOG] ✅ Backup restored!" -ForegroundColor $ColorGreen
    }
    
    Write-Host ""
    Write-Host "[TOG] Please check your internet connection and try again." -ForegroundColor $ColorYellow
}

Write-Host ""
Write-Host "Press any key to exit..." -ForegroundColor $ColorCyan
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
