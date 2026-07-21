# === ToG INSTALLER - BẢN NÂNG CẤP ===
$ErrorActionPreference = "Stop"

# === CẤU HÌNH ===
$InstallDir = "$env:APPDATA\ToG"
$RepoURL = "https://raw.githubusercontent.com/ToG-keyz/ToGs/main"

# === KIỂM TRA UNINSTALL ===
if ($args[0] -eq "uninstall" -or $args[0] -eq "-u") {
    Write-Host ""
    Write-Host "============================================================"
    Write-Host "              🗑️  UNINSTALLING ToG"
    Write-Host "============================================================"
    Write-Host ""
    
    # Xóa file
    Remove-Item -Path "$InstallDir\*" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "$InstallDir" -Force -ErrorAction SilentlyContinue
    
    # Xóa khỏi PATH
    $UserPath = [Environment]::GetEnvironmentVariable("Path","User")
    $NewPath = ($UserPath -split ';' | Where-Object {$_ -ne $InstallDir}) -join ';'
    [Environment]::SetEnvironmentVariable("Path", $NewPath, "User")
    
    # Xóa task scheduler
    schtasks /delete /tn "ToG_Update" /f 2>$null
    
    Write-Host ""
    Write-Host "✅ ToG UNINSTALLED SUCCESSFULLY!" -ForegroundColor Green
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit
}

# === BẮT ĐẦU CÀI ĐẶT ===
Write-Host ""
Write-Host "============================================================"
Write-Host "              🚀 INSTALLING ToG SYSTEM"
Write-Host "============================================================"
Write-Host ""

# === CHECK INTERNET ===
Write-Host "[TOG] Checking internet connection..." -ForegroundColor Yellow
try {
    $null = Invoke-WebRequest -Uri "https://raw.githubusercontent.com" -UseBasicParsing -TimeoutSec 5
    Write-Host "[TOG] ✅ Internet OK!" -ForegroundColor Green
} catch {
    Write-Host "[TOG] ❌ No internet connection!" -ForegroundColor Red
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit
}
Write-Host ""

try {
    # === TẠO THƯ MỤC ===
    if (!(Test-Path $InstallDir)) {
        Write-Host "[TOG] Creating directory: $InstallDir" -ForegroundColor Yellow
        New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null
        Write-Host "[TOG] ✅ Directory created!" -ForegroundColor Green
        Write-Host ""
    }

    # === XÓA FILE CŨ ===
    Write-Host "[TOG] Cleaning old files..." -ForegroundColor Yellow
    $FilesToRemove = @(
        "opentog.bat", "opentog_backup.bat", 
        "update.ps1", "update_backup.ps1",
        "tog.bat", "tog_old.bat"
    )
    
    foreach ($File in $FilesToRemove) {
        $FilePath = Join-Path $InstallDir $File
        if (Test-Path $FilePath) {
            Remove-Item -Path $FilePath -Force
            Write-Host "[TOG] 🗑️  Removed: $File" -ForegroundColor Green
        }
    }
    Write-Host "[TOG] ✅ Cleanup completed!" -ForegroundColor Green
    Write-Host ""

    # === TẢI FILE MỚI ===
    Write-Host "[TOG] Downloading files..." -ForegroundColor Yellow
    
    $Files = @{
        "opentog.bat" = "opentog.bat"
        "update.ps1" = "update.ps1"
        "tog.bat" = "tog.bat"
    }
    
    foreach ($File in $Files.Keys) {
        Write-Host "[TOG] 📥 Downloading: $File" -ForegroundColor Cyan
        try {
            Invoke-WebRequest `
                -Uri "$RepoURL/$File" `
                -OutFile "$InstallDir\$File" `
                -UseBasicParsing
            Write-Host "[TOG] ✅ Downloaded: $File" -ForegroundColor Green
        } catch {
            Write-Host "[TOG] ⚠️  Failed to download: $File" -ForegroundColor Yellow
        }
    }
    Write-Host ""

    # === THÊM VÀO PATH ===
    Write-Host "[TOG] Checking PATH..." -ForegroundColor Yellow

    $UserPath = [Environment]::GetEnvironmentVariable("Path", "User")

    if ($UserPath -notlike "*$InstallDir*") {
        Write-Host "[TOG] Adding ToG to PATH..." -ForegroundColor Cyan

        if ([string]::IsNullOrWhiteSpace($UserPath)) {
            $NewPath = $InstallDir
        } else {
            $NewPath = "$UserPath;$InstallDir"
        }

        [Environment]::SetEnvironmentVariable("Path", $NewPath, "User")
        Write-Host "[TOG] ✅ PATH updated successfully!" -ForegroundColor Green
    } else {
        Write-Host "[TOG] ✅ PATH already configured." -ForegroundColor Green
    }
    Write-Host ""

    # === TẠO TASK UPDATE TỰ ĐỘNG ===
    Write-Host "[TOG] Creating auto-update task..." -ForegroundColor Yellow
    $TaskName = "ToG_Update"
    $TaskAction = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -File `"$InstallDir\update.ps1`""
    $TaskTrigger = New-ScheduledTaskTrigger -Daily -At 3am
    $TaskPrincipal = New-ScheduledTaskPrincipal -UserId "$env:USERNAME" -LogonType Interactive
    
    try {
        Register-ScheduledTask -TaskName $TaskName -Action $TaskAction -Trigger $TaskTrigger -Principal $TaskPrincipal -Force -ErrorAction SilentlyContinue
        Write-Host "[TOG] ✅ Auto-update created! (Daily at 3AM)" -ForegroundColor Green
    } catch {
        Write-Host "[TOG] ⚠️  Could not create scheduled task" -ForegroundColor Yellow
    }
    Write-Host ""

    # === KIỂM TRA FILE ===
    Write-Host "[TOG] Verifying installation..." -ForegroundColor Yellow
    
    $InstalledFiles = Get-ChildItem -Path $InstallDir -File
    $FileCount = $InstalledFiles.Count
    
    if ($FileCount -gt 0) {
        Write-Host ""
        Write-Host "============================================================" -ForegroundColor Green
        Write-Host "        ✅ ToG INSTALLED SUCCESSFULLY!                      " -ForegroundColor Green
        Write-Host "============================================================" -ForegroundColor Green
        Write-Host ""
        Write-Host "  📁 Install Path:" -ForegroundColor Yellow
        Write-Host "     $InstallDir" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "  📄 Files installed ($FileCount files):" -ForegroundColor Yellow
        foreach ($F in $InstalledFiles) {
            $Size = [math]::Round($F.Length / 1KB, 2)
            Write-Host "     $($F.Name)  ($Size KB)" -ForegroundColor Cyan
        }
        Write-Host ""
        Write-Host "  🚀 To run ToG, open a new CMD and type:" -ForegroundColor Yellow
        Write-Host "     opentog" -ForegroundColor Green
        Write-Host "     tog" -ForegroundColor Green
        Write-Host ""
        Write-Host "  🔄 To update ToG, type:" -ForegroundColor Yellow
        Write-Host "     update" -ForegroundColor Green
        Write-Host ""
        Write-Host "  🗑️  To uninstall ToG, type:" -ForegroundColor Yellow
        Write-Host "     update -u" -ForegroundColor Green
        Write-Host "     (or run this script with -u argument)" -ForegroundColor Cyan
        Write-Host ""
    } else {
        throw "No files were installed!"
    }

} catch {
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
    Write-Host "  5. Run: Set-ExecutionPolicy Unrestricted -Scope Process" -ForegroundColor Cyan
    Write-Host ""
}

Write-Host ""
Read-Host "Press Enter to exit"
