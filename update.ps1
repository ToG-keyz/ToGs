$InstallDir = "$env:LOCALAPPDATA\ToG"

Invoke-WebRequest `
    -Uri "https://raw.githubusercontent.com/ToG-keyz/ToGs/main/opentog.bat" `
    -OutFile "$InstallDir\opentog.bat"

Write-Host ""
Write-Host "Update completed."
