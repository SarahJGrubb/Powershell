#Connect-MicrosoftTeams
#Connect-MsolService

#Create HashTable
#HashTable is cleared first using $NULL
$hash = $null
$hash = @{}

#Get the Team ID
do {
    $displayName = Read-Host -Prompt "Enter the Team Name (**Must be exact**)"

    try {
        $team = Get-Team | Where-Object {$_.DisplayName -eq $displayName}

        if (-not $team) {
            Write-Host "No Team found with the name '$displayName'. Please check name and try again"
        }
    }
    catch {
        Write-Host "An error occurred while retrieving the team: $_"
        $team = $null
    }
} while (-not $team)

#Check if the users have a license assigned. 
$unlicensedUsers = @()

foreach ($user in $hash.GetEnumerator()) {
    $email = $user.Value

    try {
        $licensed = Get-MsolUser -UserPrincipalName $email -ErrorAction Stop

        if ($licensed.isLicensed -eq $false) {
            Remove-UnifiedGroupLinks -Identity $displayName -LinkType Members -Links $email -Confirm:$FALSE
            $unlicensedUsers += $email
        }
        else {
            Write-Host "$email - User is licensed"
        }
    }
    catch {
        Write-Host "Error checking license for '$email': $_"
    }
}

if ($unlicensedUsers.count -gt 0) {
    Write-Host "Unlicensed Users removed: $($unlicensedUsers -join ', ')"
} else {
    Write-Host "No unlicensed users found."
}


