#Working Version. Last merged with testing 3:40 pm 12/9/2021
Write-host "Installing NuGet...."
Install-PackageProvider NuGet -Force > $null
Write-Host "Installing pswindowsupdate....."
Install-Module pswindowsupdate -Confirm:$false -Force > $null
Clear-Host
$ProgramsToInstall = Get-Content ..\apps.txt
try {
    choco -v > $null
    Clear-Host
    Write-Host "Install apps from the app file......."
    foreach ($app in $ProgramsToInstall) {
        choco install $app -r -y
        $Host.ui.RawUI.WindowTitle = "Installing " + $app.ToUpper() + "...."
        Clear-Host
    }
    Clear-Host
}
catch [System.Management.Automation.CommandNotFoundException]{
    Write-host "Choco package manager is not installed."
    Write-host "Choco will now be installed...."
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    Clear-Host
    Write-Host "Install apps from the app file......."
    foreach ($app in $ProgramsToInstall) {
        Clear-Host
        $Host.ui.RawUI.WindowTitle = "Installing " + $app.ToUpper() + "...."
        choco install $app -r -y
    }
    Clear-Host
}
Write-Host "Everything within your list is installed. Now running windows updates"
Write-host "Please wait as this may take some time...."
$Host.ui.RawUI.WindowTitle = "Installing Windows Updates..."
Install-WindowsUpdate -Confirm:$false > $null