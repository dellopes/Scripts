$SerialNumber = (Get-WmiObject -class win32_bios).SerialNumber
$ComputerName = "M4ST3R-$SerialNumber"
$ActualHostname = (hostname)

if ($ComputerName -ne $ActualHostname){
    Rename-Computer -NewName $ComputerName -Restart -Force}
else {
    Write-Host "Mesmo Hostname" -ForegroundColor Yellow}
exit