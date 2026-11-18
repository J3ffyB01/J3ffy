
#enables Hyper-V powershell features
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
#parameters for server
$VMName = "vm name"
$VMPath = "path/to/vm/location"
$VHDPath = "path/to/vhd/endsin.vhdx"
$ISOPath = "path/to/iso"
$Switchname = "switch name"

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
$DVD = Get-VMDvdDrive -VMName $VMName
Set-VMFirmware -VMName $VMName -FirstBootDevice $DVD
Set-VMFirmware -VMName $VMName -EnableSecureBoot Off
Start-VM -Name $VMName
vmconnect.exe localhost $VMName