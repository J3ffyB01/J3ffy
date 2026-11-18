Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
#parameters for server
$VMName = "winserv25_dc"
$VMPath = "C:\Users\J3ffyB01\VM"
$VHDPath = "C:\Users\J3ffyB01\VHD\winserv25_dc.vhdx"
$ISOPath = "C:\Users\J3ffyB01\ISOs\26100.32230.260111-0550.lt_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso"
$Switchname = "Homelab - LAN"

#actual setup begins
New-VM -Name $VMName `
        -MemoryStartupBytes 8GB `
        -Generation 2 `
        -Path $VMPath `
        -NewVHDPath $VHDPath `
        -NewVHDSizeBytes 100GB `
        -SwitchName $Switchname
Set-VM -Name $VMName -ProcessorCount 4
Add-VMDvdDrive -VMName $VMName -Path $ISOPath
$DVD = Get-VMDvdDrive -VMName $VMName
Set-VMFirmware -VMName $VMName -FirstBootDevice $DVD
Set-VMFirmware -VMName $VMName -EnableSecureBoot Off
Start-VM -Name $VMName
vmconnect.exe localhost $VMName