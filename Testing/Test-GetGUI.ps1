Add-Type -assembly System.windows.Forms

$main_form = New-Object System.windows.Forms.Form

$main_form.Text = 'Test'
$main_form.Width = 600
$main_form.Height = 400
#$main_form.AutoSize = $true

$main_form.ShowDialog()