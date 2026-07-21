$InstallDir = "$env:LOCALAPPDATA\ToG"

# Tạo thư mục
if (!(Test-Path $InstallDir)) {
    New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null
}

# Tải opentog
Invoke-WebRequest `
    -Uri "https://raw.githubusercontent.com/ToG-keyz/ToGs/main/opentog.bat" `
    -OutFile "$InstallDir\opentog.bat"

# Tải update
Invoke-WebRequest `
    -Uri "https://raw.githubusercontent.com/ToG-keyz/ToGs/main/update.ps1" `
    -OutFile "$InstallDir\update.ps1"

# Thêm PATH
$UserPath = [Environment]::GetEnvironmentVariable("Path","User")

if ([string]::IsNullOrWhiteSpace($UserPath)) {
    $UserPath = ""
}

$Paths = $UserPath.Split(';') | ForEach-Object { $_.Trim() }

if ($Paths -notcontains $InstallDir) {
    $NewPath = if ($UserPath) {
        "$UserPath;$InstallDir"
    } else {
        $InstallDir
    }

    [Environment]::SetEnvironmentVariable("Path",$NewPath,"User")

    Write-Host "[TOG] PATH added."
}
else {
    Write-Host "[TOG] PATH already exists."
}

Write-Host ""
Write-Host "Installation completed."
Write-Host ""
Write-Host "Close CMD and open a new CMD."
Write-Host "Then type:"
Write-Host ""
Write-Host "    opentog"
