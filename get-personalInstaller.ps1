#Checking for choco

$isChocoInstalled = powershell choco -v

if (-not ($isChocoInstalled)) {
    Write-host "Choco package manager is not installed or can not be found"
    set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
else {
    Write-host "Choco is installed." $isChocoInstalled
}
#to install without prompt pass -y or enable it globally

#TODO: above is commented for the time being during testing please remove all the comments from the above code.

$ProgramsToInstall = "steam","GoogleChrome","FireFox","origin","vscode","vlc","powertoys","microsoft-windows-terminal","ccleaner","7zip","filezilla","git","github-desktop","battle.net"


foreach ($app in $ProgramsToInstall) {
    choco install $app -y
}