$removeThese = Get-CimInstance -Class Win32_UserProfile -verbose | Where-Object {(!$_.Special)}
foreach ($remove in $removeThese) {
Remove-CimInstance $remove -Confirm:$FALSE -ErrorAction continue -ErrorVariable RemoveError
}

$profiledirectory="C:\Users\"
Get-ChildItem -Path $profiledirectory -verbose | Where-Object {($_.FullName -notmatch 'Administrator|Public|Operator|Default') }
    ForEach-Object{
        Get-ChildItem 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\ProfileList' -verbose |
            ForEach-Object{
            $profilepath=$_.GetValue('ProfileImagePath')    
            if($profilepath -notmatch 'administrator|Operator|NetworkService|Localservice|systemprofile|LocalAdmin'){
                Write-Host "Removing item: $profilepath" -ForegroundColor green -verbose
                Remove-Item $_.PSPath -verbose
                Remove-Item $profilepath -Recurse -Force -verbose
            }else{
                Write-Host "Skipping item:$profilepath" -Fore blue -Back white -verbose
            }
        }
    }
 