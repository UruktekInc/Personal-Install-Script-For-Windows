#THIS IS THE TEST VERSION WHICH MAY OR MAY NOT BE BROKEN
#USE AT YOUR OWN RISK

#Checking for choco
$isChocoInstalled = choco -v 
#This installs nuget so that the install-mod will not prompt for it
Install-PackageProvider NuGet -Force > $null
#this installs pswindowsupdate to install windows update from ps
Install-Module pswindowsupdate -Confirm:$false -Force > $null

#TODO: Use gc to pull from app.txt of the list of file to install rather than using a hard coded arraylist
#$ProgramsToInstall = "steam","GoogleChrome","FireFox","origin","vscode","vlc","powertoys","microsoft-windows-terminal","ccleaner","7zip","filezilla","git","github-desktop"
$ProgramsToInstall = Get-Content ..\apps.txt

# if (-not ($isChocoInstalled)) {
#     Write-host "Choco package manager is not installed or can not be found"
#     set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
#     foreach ($app in $ProgramsToInstall) {
#         #TODO: Add supressed output to screen EG "installing X..."
#         choco install $app -r -y
#     }
# }
# else {
#     Write-host "Choco is installed." $isChocoInstalled
#     foreach ($app in $ProgramsToInstall) {
#         #TODO: Add supressed output to screen EG "installing X..."
#         choco install $app -y
#     }
# }


try {
    choco -v > $null
    
    Clear-Host

    Write-Host "Install apps from the app file......."
    foreach ($app in $ProgramsToInstall) {
        choco install $app -r -y
    }

    Clear-Host

}
catch [System.Management.Automation.CommandNotFoundException]{
    Write-host "Choco package manager is not installed."
    Write-host "Choco will now be installed...."
    set-ExecutionPolicy Bypass -Scope Process -Force > $null #execution before running should be changed however this is suggested by the dev. Hush output.
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

    Clear-Host

    Write-Host "Install apps from the app file......."
    foreach ($app in $ProgramsToInstall) {
        choco install $app -r -y
    }

    Clear-Host
}


#Installing windows update from pswindowsupdate module
Write-Host "Everything within your list is installed. Now running windows updates"
Write-host "Please wait as this may take some time...."
Install-WindowsUpdate -Confirm:$false > $null