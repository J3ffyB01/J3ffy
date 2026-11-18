Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
#parameters for server
$VMName = "win11_test"
$VMPath = "C:\Users\J3ffyB01\VM"
$VHDPath = "C:\Users\J3ffyB01\VHD\win11_test.vhdx"
$ISOPath = "C:\Users\J3ffyB01\ISOs\26300.9457.260913-1737.26h2_ge_release_svc_refresh_CLIENTENTERPRISEEVAL_OEMRET_x64FRE_en-us.iso"
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