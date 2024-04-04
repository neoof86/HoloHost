$scriptDrive = Get-Volume -FileSystemLabel '*ESXI*'
$DriveLabel = Get-Volume -DriveLetter $scriptDrive.DriveLetter | select FileSystemLabel
$cfgpath = $scriptDrive.DriveLetter + ":\efi\boot\boot.cfg"
$drivepath =  $scriptDrive.DriveLetter + ":\"

write-host "Can I assume that I have right drive as" $DriveLetter "showing as label" $DriveLabel.FileSystemLabel

$answer = read-host "yes or no? "
if ($answer -eq 'yes') { 

((Get-Content -path $cfgpath -Raw) -replace 'title=Loading ESXi installer','title=Loading ESXi HoloDeck Host installer') | Set-Content -Path $cfgpath 


((Get-Content -path $cfgpath -Raw) -replace 'kernelopt=runweasel cdromBoot','kernelopt=runweasel ks=usb:/KS.CFG cdromBoot') | Set-Content -Path $cfgpath

Copy-Item .\ks.cfg -Destination "$drivepath"

} else {
Write-Host "Bye!"
} 

