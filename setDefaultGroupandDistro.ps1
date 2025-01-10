Connect-ExchangeOnline

#365 Groups
$defaultGroupsLocation1 = 'email@org.com', 'email@org.com', 'email@org.com@org.com'
$defaultGroupsLocation2 = 'email@org.com', 'email@org.com', 'email@org.com@org.com'
$defaultGroupsLocation3 = 'email@org.com', 'email@org.com', 'email@org.com@org.com'
$defaultGroupsLocation4 = 'email@org.com', 'email@org.com', 'email@org.com@org.com'
$defaultGroupsLocation5 = 'email@org.com', 'email@org.com', 'email@org.com@org.com'
$defaultGroupsLocation6 = 'email@org.com', 'email@org.com@org.com'
$defaultGroupsLocation7 = 'email@org.com', 'email@org.com@org.com'
$defaultGroupsLocation8 = 'email@org.com', 'email@org.com@org.com'

#Distros
$defaultDistrosLocation1 = 'email@org.com', 'email@org.com'
$defaultDistrosLocation2 = 'email@org.com', 'email@org.com'
$defaultDistrosLocation3 = 'email@org.com', 'email@org.com'
$defaultDistrosLocation4 = 'email@org.com', 'email@org.com'
$defaultDistrosLocation5 = 'email@org.com', 'email@org.com'
$defaultDistrosLocation6 = 'email@org.com', 'email@org.com', 'email@org.com'
$defaultDistrosLocation7 = 'email@org.com', 'email@org.com'
$defaultDistrosLocation8 = 'email@org.com', 'email@org.com'

function getInput {
    $choice = Read-Host "Choose input method: [1] CSV File [2] Manual Entry"

    if ($choice -eq 2) {
        do {
            $username = Read-Host "Please enter user email" #Can update this to verify that the email@org.com exist before proceeding.
            try {
                $knownemail = Get-Mailbox -Identity $username
        
                if (-not $knownemail) {
                    Write-Host "email@org.com Address does not exist. Please check the spelling and try again."
                }
            }
            catch {
                $knownemail = $null
            }
        } while (-not $knownemail)
        
        #Office Location
        $officeLocation = Read-Host "Which office?" 

        processUser $username $officeLocation

    }
    elseif ($choice -eq 1) {
        do {
            $filePath = Read-Host "Enter the path to the CSV file"
            $fileName = "TestAddUsersToTeams.csv"
     
            try {
                if (-not (Test-Path $filePath)) {
                    Write-Host "File Path does not exist, please try again."
                }
            }
            catch {
                $filePath = $null
            }
        } while (-not (Test-Path $filePath))
    }
     
    try {
        $usersToAdd = Import-Csv ($filePath + "\" + $fileName) 
         
        foreach ($user in $usersToAdd) {
            $username = $user.email
            $officeLocation = $user.location
            processUser $username $officeLocation
        } 
    }
    catch {
        Write-Host "Error occurred $_"
    }
    continueOn
     

} 

function processUser {
    param (
        [string]$username,
        [string]$officeLocation
    )

    try {
        switch ($officeLocation) {
            "Office1" {
                foreach ($distro in $defaultDistrosLocation1) {
                    Add-DistributionGroupMember -Identity $distro -Member $username
                }
                foreach ($group in $defaultGroupsLocation1) {
                    Add-UnifiedGroupLinks -Identity $group -LinkType Members -Links $username
                }
            }
            "Office2" {
                foreach ($distro in $defaultDistrosLocation2) {
                    Add-DistributionGroupMember -Identity $distro -Member $username
                }
                foreach ($group in $defaultGroupsLocation2) {
                    Add-UnifiedGroupLinks -Identity $group -LinkType Members -Links $username
                }
            }
            "Office3" {
                foreach ($distro in $defaultDistrosLocation3) {
                    Add-DistributionGroupMember -Identity $distro -Member $username
                }
                foreach ($group in $defaultGroupsLocation3) {
                    Add-UnifiedGroupLinks -Identity $group -LinkType Members -Links $username
                }
            }
            "Office4" {
                foreach ($distro in $defaultDistrosLocation4) {
                    Add-DistributionGroupMember -Identity $distro -Member $username
                }
                foreach ($group in $defaultGroupsLocation4) {
                    Add-UnifiedGroupLinks -Identity $group -LinkType Members -Links $username
                }
            }
            "Office5" {
                foreach ($distro in $defaultDistrosLocation5) {
                    Add-DistributionGroupMember -Identity $distro -Member $username
                }
                foreach ($group in $defaultGroupsLocation5) {
                    Add-UnifiedGroupLinks -Identity $group -LinkType Members -Links $username
                }
            }
            "Office6" {
                foreach ($distro in $defaultDistrosLocation6) {
                    Add-DistributionGroupMember -Identity $distro -Member $username
                }
                foreach ($group in $defaultGroupsLocation6) {
                    Add-UnifiedGroupLinks -Identity $group -LinkType Members -Links $username
                }
            }
            "Office7" {
                foreach ($distro in $defaultDistrosLocation7) {
                    Add-DistributionGroupMember -Identity $distro -Member $username
                }
                foreach ($group in $defaultGroupsLocation7) {
                    Add-UnifiedGroupLinks -Identity $group -LinkType Members -Links $username
                }
            }
            "Office8" {
                foreach ($distro in $defaultDistrosLocation8) {
                    Add-DistributionGroupMember -Identity $distro -Member $username
                }
                foreach ($group in $defaultGroupsLocation8) {
                    Add-UnifiedGroupLinks -Identity $group -LinkType Members -Links $username
                }
            }
        }
    }
    catch {
        Write-Host "Error occurred while processing user $_"
    }
}

function continueOn {
    $answer = Read-Host "Do you want to continue? [Y]es or [N]o"

    if ($answer -eq "Y") {
        getInput
    }
    else {
        Write-Host "Exiting..."
    }
}

getInput
