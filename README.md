This is just a personal script for Chocolaty.

Should you want to use it feels free.

Apps are installed based on what's found within the app.txt file

Highly suggest using production version as testing can be in a broken state.

This was confirmed working on a Windows 10 and Windows 11 machine.

Results on other versions of windows may be different.

Make sure that you allow for unrestricted scripts before running this application.
(Set-ExecutionPolicy Unrestricted) -- an example
Also, make sure that this is run from an admin powershell instance.

A tour into the code.

First this will install nuget which is a requirement for install ps modules.
Then it will install pswindowsupdate a ps tool to install windows updates from powershell.
Next it will make a ps object from the app.txt file.
Then starts the main loop of a try block.
It will try to execute choco -v which is just a basic version checking command and it's sent to null to suppress the output.
If choco isn't installed commandnotfound exception will be thrown causing it to install choco for you.
After this it will loop over the now psobject of $app and change the title of the ps window to
show what's being installed at the moment.
choco install $app -r -y (-r suppresses what choco considers non-essential output -y forces yes to everything that would be prompted like EULAs and agreements).

After the main loop is done it will then run install-windowsupdate from the pswindowsupdate module and confirm it while suppressing the output.