Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
#parameters for server
$VMName = "ubuntu_test"
$VMPath = "C:\Users\J3ffyB01\VM"
$VHDPath = "C:\Users\J3ffyB01\VHD\ubuntu_test.vhdx"
$ISOPath = "C:\Users\J3ffyB01\ISOs\ubuntu-26.04.1-desktop-amd64.iso"
$Switchname = "Homelab - LAN"

#actual setup begins
New-VM -Name $VMName `
        -MemoryStartupBytes 4GB `
        -Generation 2 `
        -Path $VMPath `
        -NewVHDPath $VHDPath  `
        -NewVHDSizeBytes 50GB `
        -SwitchName $Switchname
Set-VM -Name $VMName -ProcessorCount 2
Add-VMDvdDrive -VMName $VMName -Path $ISOPath
$DVD = Get-VMDvdDrive -VMName $VMName
Set-VMFirmware -VMName $VMName -FirstBootDevice $DVD
Set-VMFirmware -VMName $VMName -EnableSecureBoot Off
Start-VM -Name $VMName
vmconnect.exe localhost $VMName