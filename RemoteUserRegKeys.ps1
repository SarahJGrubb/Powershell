try {
    $CurrentErrorActionPreference = $ErrorActionPreference
    $ErrorActionPreference = 'Stop'
    $Key = "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Cryptography\Protect\Providers\df9d8cd0-1501-11d1-8c7a-00c04fc297eb";
    if (Test-Path -Path $Key) {
        Write-Host -ForegroundColor Green -BackgroundColor Black "Key:df9d8cd0-1501-11d1-8c7a-00c04fc297eb - already exist"
    }
    Else {
        New-Item -Path $Key
    }
    if (Get-ItemProperty -Path $Key -Name ProtectionPolicy) {
        Write-Host -ForegroundColor Green -BackgroundColor Black "ProtectionPolicy Property already exist"
    }
}
catch {
    Write-Host -f Red "Encountered Error:" $_.Exception.Message
}
finally {
    $ErrorActionPreference = $CurrentErrorActionPreference
    Set-ItemProperty -Path $Key -Name ProtectionPolicy -Value 0
}

try {
    $CurrentErrorActionPreference = $ErrorActionPreference
    $ErrorActionPreference = 'Stop'
    $Key = "Registry::HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\Identity";
    if (Test-Path -Path $Key) {
        Write-Host -ForegroundColor Green -BackgroundColor Black "Identity Key already exist"
    }
    else {
        New-Item -Path $Key
    }
    if(Get-ItemProperty -Path $Key -Name EnableADAL) {
        Write-Host -ForegroundColor Green -BackgroundColor Black "EnableADAL Property already exist"
    }
}
catch {
    Write-Host -f Red "Encountered Error:" $_.Exception.Message
}
finally {
    $ErrorActionPreference = $CurrentErrorActionPreference
    Set-ItemProperty -Path $Key -Name EnableADAL -Value "0"
}
Read-Host "Press Enter to Exit"