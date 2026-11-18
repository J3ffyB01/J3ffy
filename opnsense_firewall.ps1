Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
#parameters for server
$VMName = "opnsense_firewall"
$VMPath = "C:\Users\J3ffyB01\VM"
$VHDPath = "C:\Users\J3ffyB01\VHD\opnsense_firewall.vhdx"
$ISOPath = "C:\Users\J3ffyB01\ISOs\OPNsense-26.7-dvd-amd64.iso"
$Switchname = "Homelab - LAN"

#actual setup begins
New-VM -Name $VMName `
        -MemoryStartupBytes 8GB `
        -Generation 2 `
        -Path $VMPath `
        -NewVHDPath $VHDPath  `
        -NewVHDSizeBytes 100GB `
        -SwitchName $Switchname
Set-VM -Name $VMName -ProcessorCount 4
Add-VMDvdDrive -VMName $VMName -Path $ISOPath
Add-VMNetworkAdapter -VMName "opnsense_firewall" -Name "local-lan" -SwitchName "local-lan"
$DVD = Get-VMDvdDrive -VMName $VMName
Set-VMFirmware -VMName $VMName -FirstBootDevice $DVD
Set-VMFirmware -VMName $VMName -EnableSecureBoot Off
Start-VM -Name $VMName
vmconnect.exe localhost $VMName