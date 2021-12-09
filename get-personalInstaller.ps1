#Checking for choco
$isChocoInstalled = choco -v


#Known issues
#TODO: Battle.net prompts that the hash is mismatched and prompts for further confirmation you can press y
#TODO: Also bnet prompts for further install instructions may want to remove this for the time being
#TODO: Github desktop will auto launch

#install windows update ps module

#This installs nuget so that the install-mod will not prompt for it
Install-PackageProvider NuGet -Force
#this installs pswindowsupdate to install windows update from ps
Install-Module pswindowsupdate -Confirm:$false -Force


#Perhaps this should be inside an txt file or an ini for simplicity?
$ProgramsToInstall =
"steam"
,"GoogleChrome"
,"FireFox"
,"origin"
,"vscode"
,"vlc"
,"powertoys"
,"microsoft-windows-terminal"
,"ccleaner"
,"7zip"
,"filezilla"
,"git"
,"github-desktop"

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

#Installing windows update from pswindowsupdate module
Write-Host "Everything within your list is installed. Now running windows updates"
Get-WindowsUpdate | Install-WindowsUpdate