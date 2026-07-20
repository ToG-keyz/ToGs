$InstallDir = "$env:LOCALAPPDATA\ToG"

$DownloadUrl = "https://raw.githubusercontent.com/tog-keyz/tog-system/main/opentog.bat"

$CurrentFile = "$InstallDir\opentog.bat"
$NewFile = "$InstallDir\opentog_new.bat"

Write-Host ""
Write-Host "==================================="
Write-Host "         Updating ToG..."
Write-Host "==================================="
Write-Host ""

try {

    Invoke-WebRequest `
        -Uri $DownloadUrl `
        -OutFile $NewFile

    if (!(Test-Path $NewFile)) {
        throw "Download failed."
    }

    Write-Host ""
    Write-Host "Update downloaded."
    Write-Host "Replacing files..."

    Start-Process cmd -ArgumentList "/c ping 127.0.0.1 -n 2 >nul && move /Y `"$NewFile`" `"$CurrentFile`" >nul"

    Write-Host ""
    Write-Host "==================================="
    Write-Host " ToG updated successfully!"
    Write-Host "==================================="
    Write-Host ""
    Write-Host "Close this window and run 'opentog' again."

}
catch {

    Write-Host ""
    Write-Host "==================================="
    Write-Host " Update failed!"
    Write-Host "==================================="
    Write-Host $_.Exception.Message

}
