#Checking for choco

$isChocoInstalled = powershell choco -v

$ProgramsToInstall = "steam","GoogleChrome","FireFox","origin","vscode","vlc","powertoys","microsoft-windows-terminal","ccleaner","7zip","filezilla","git","github-desktop","battle.net"

if (-not ($isChocoInstalled)) {
    Write-host "Choco package manager is not installed or can not be found"
    set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    foreach ($app in $ProgramsToInstall) {
        choco install $app -y
    }
}
else {
    Write-host "Choco is installed." $isChocoInstalled
    foreach ($app in $ProgramsToInstall) {
        choco install $app -y
    }
}