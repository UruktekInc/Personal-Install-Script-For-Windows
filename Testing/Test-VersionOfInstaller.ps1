#THIS IS THE TEST VERSION WHICH MAY OR MAY NOT BE BROKEN
#USE AT YOUR OWN RISK

#Checking for choco
$isChocoInstalled = choco -v
#This installs nuget so that the install-mod will not prompt for it
Install-PackageProvider NuGet -Force
#this installs pswindowsupdate to install windows update from ps
Install-Module pswindowsupdate -Confirm:$false -Force


#TODO: Use gc to pull from app.txt of the list of file to install rather than using a hard coded arraylist
#$ProgramsToInstall = "steam","GoogleChrome","FireFox","origin","vscode","vlc","powertoys","microsoft-windows-terminal","ccleaner","7zip","filezilla","git","github-desktop"
$ProgramsToInstall = Get-Content .\apps.txt

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

#TODO:FOR TESTING REASONS WINDOWS UPDATES ARE DISABLED BY DEFAULT

# #Installing windows update from pswindowsupdate module
# Write-Host "Everything within your list is installed. Now running windows updates"
# Install-WindowsUpdate -Confirm:$false