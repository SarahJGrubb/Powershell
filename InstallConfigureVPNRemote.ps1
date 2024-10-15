#if ($PSVersionTable.PSVersion -ne [Version]"5.1") {
#  # Re-launch as version 5 if we're not already
#  powershell -Version 5.1 -File $MyInvocation.MyCommand.Definition
#  exit
#}
try {
    $CurrentErrorActionPreference = $ErrorActionPreference
    $ErrorActionPreference = 'Stop'
    ECHO Y | winget install "azure vpn client"
}
catch {
    Write-host -f red "Encountered Error:" $_.Exception.Message 
}

try {
    $CurrentErrorActionPreference = $ErrorActionPreference
    $ErrorActionPreference = 'Stop'
    #$loggedonuser = Get-CimInstance -classname Win32_ComputerSystem | Select-Object UserName
    $loggedonuser = $Env:USERNAME
    Copy-Item -Path "C:\Users\$loggedonuser\Documents\SoftwareAndConfigs\FM_VNET_NC.AzureVpnProfileTest2.xml" -Destination "C:\Users\$loggedonuser\AppData\Local\Packages\Microsoft.AzureVpn_8wekyb3d8bbwe\LocalState"
    #move xml to %userprofile%\AppData\Local\Packages\Microsoft.AzureVpn_8wekyb3d8bbwe\LocalState
}
catch {
    Write-host -f red "Encountered Error:" $_.Exception.Message 
}
finally {
    $ErrorActionPreference = $CurrentErrorActionPreference
}

Start-Sleep -Seconds 10
try {
    $CurrentErrorActionPreference = $ErrorActionPreference
    $ErrorActionPreference = 'Stop'
    azurevpn -i FM_VNET_NC.AzureVpnProfileTest2.xml -f
}
catch {
    $Error
}
finally {
    $ErrorActionPreference = $CurrentErrorActionPreference
}

Read-Host -Prompt "Press enter to exit"