$scriptDrive = Get-Volume -FileSystemLabel '*ESXI*'
$DriveLabel = Get-Volume -DriveLetter $scriptDrive.DriveLetter | select FileSystemLabel
$cfgpath = $scriptDrive.DriveLetter + ":\efi\boot\boot.cfg"
$drivepath =  $scriptDrive.DriveLetter + ":\"

write-host "Can I assume that I have right drive as" $DriveLetter "showing as label" $DriveLabel.FileSystemLabel

$answer = read-host "yes or no? "
if ($answer -eq 'yes') { 

((Get-Content -path $cfgpath -Raw) -replace 'title=Loading ESXi installer','title=Loading ESXi HoloDeck Host installer') | Set-Content -Path $cfgpath 


((Get-Content -path $cfgpath -Raw) -replace 'kernelopt=runweasel cdromBoot','kernelopt=runweasel ks=usb:/KS.CFG cdromBoot') | Set-Content -Path $cfgpath


#Parameters
$URL = "https://raw.githubusercontent.com/neoof86/HoloHost/main/ks.cfg"
$DownloadPath = "$drivepath ks.cfg"
 
Start-BitsTransfer -Source $URL -Destination $DownloadPath

Write-Host "All done! Remember to disable Secure Boot in your BIOS!!! Enjoy :)"
} else {
Write-Host "Bye!"
} 

