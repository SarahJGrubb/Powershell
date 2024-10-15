Connect-ExchangeOnline

#365 Groups
$defaultGroupsChatt = 'fitzmark2@fitzmark.com','Trenches','Chatt'
$defaultGroupsAtl = 'fitzmark2@fitzmark.com','Trenches','Atlanta Office'
$defaultGroupsGvl = 'fitzmark2@fitzmark.com','Trenches','Gainesville'
$defaultGroupsKck = 'fitzmark2@fitzmark.com','Trenches','Kansas City'
$defaultGroupsBuf = 'fitzmark2@fitzmark.com','Trenches','Buffalo'
$defaultGroupsIndy = 'fitzmark2@fitzmark.com','Indy Office'
$defaultGroupsDet = 'fitzmark2@fitzmark.com','Detroit'
$defaultGroupsOma = 'fitzmark2@fitzmark.com','Omaha'

#Distros
$defaultDistrosChatt = 'Employees','fitzmark@fitzmark.com'
$defaultDistrosAtl = 'Employees','fitzmark@fitzmark.com'
$defaultDistrosGvl = 'Employees','fitzmark@fitzmark.com'
$defaultDistrosKck = 'Employees','fitzmark@fitzmark.com'
$defaultDistrosBuf = 'Employees','fitzmark@fitzmark.com'
$defaultDistrosIndy = 'Employees','fitzmark@fitzmark.com','Indy'
$defaultDistrosDet = 'Employees','fitzmark@fitzmark.com'
$defaultDistrosOma = 'Employees','fitzmark@fitzmark.com'

function getInput {
    $choice = Read-Host "Choose input method: [1] CSV File [2] Manual Entry"

    if ($choice -eq 2) {
        do {
            $username = Read-Host "Please enter user email" #Can update this to verify that the email exist before proceeding.
            try {
                $knownEmail = Get-Mailbox -Identity $username
        
                if (-not $knownEmail) {
                    Write-Host "Email Address does not exist. Please check the spelling and try again."
                }
            }
            catch {
                $knownEmail = $null
            }
        } while (-not $knownEmail)
        
        #Office Location
        $officeLocation = Read-Host "Which office?" 

        processUser $username $officeLocation

    }
    elseif ($choice -eq 1) {
        do {
         $filePath = Read-Host "Enter the path to the CSV file"
         $fileName = "TestAddUsersToTeams.csv"
     
         try {
             if(-not (Test-Path $filePath)) {
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
     } catch {
             Write-Host "Error occurred $_"
     }
     

} 

function processUser {
    param (
        [string]$username,
        [string]$officeLocation
    )

    try {
        switch ($officeLocation) {
            "Chattanooga" {
                foreach ($distro in $defaultDistrosChatt) {
                    Add-DistributionGroupMember -Identity $distro -Member $username
                }
                foreach ($group in $defaultGroupsChatt) {
                    Add-UnifiedGroupLinks -Identity $group -LinkType Members -Links $username
                }
            }
            "Atlanta" {
                foreach ($distro in $defaultDistrosAtl) {
                    Add-DistributionGroupMember -Identity $distro -Member $username
                }
                foreach ($group in $defaultGroupsAtl) {
                    Add-UnifiedGroupLinks -Identity $group -LinkType Members -Links $username
                }
            }
            "Gainesville" {
                foreach ($distro in $defaultDistrosGvl) {
                    Add-DistributionGroupMember -Identity $distro -Member $username
                }
                foreach ($group in $defaultGroupsGvl) {
                    Add-UnifiedGroupLinks -Identity $group -LinkType Members -Links $username
                }
            }
            "Indianapolis" {
                foreach ($distro in $defaultDistrosIndy) {
                    Add-DistributionGroupMember -Identity $distro -Member $username
                }
                foreach ($group in $defaultGroupsIndy) {
                    Add-UnifiedGroupLinks -Identity $group -LinkType Members -Links $username
                }
            }
            "Buffalo" {
                foreach ($distro in $defaultDistrosBuf) {
                    Add-DistributionGroupMember -Identity $distro -Member $username
                }
                foreach ($group in $defaultGroupsBuf) {
                    Add-UnifiedGroupLinks -Identity $group -LinkType Members -Links $username
                }
            }
            "KansasCity" {
                foreach ($distro in $defaultDistrosKck) {
                    Add-DistributionGroupMember -Identity $distro -Member $username
                }
                foreach ($group in $defaultGroupsKck) {
                    Add-UnifiedGroupLinks -Identity $group -LinkType Members -Links $username
                }
            }
            "Detroit" {
                foreach ($distro in $defaultDistrosDet) {
                    Add-DistributionGroupMember -Identity $distro -Member $username
                }
                foreach ($group in $defaultGroupsDet) {
                    Add-UnifiedGroupLinks -Identity $group -LinkType Members -Links $username
                }
            }
            "Omaha" {
                foreach ($distro in $defaultDistrosOma) {
                    Add-DistributionGroupMember -Identity $distro -Member $username
                }
                foreach ($group in $defaultGroupsOma) {
                    Add-UnifiedGroupLinks -Identity $group -LinkType Members -Links $username
                }
            }
        }
    }
    catch {
        Write-Host "Error occurred while processing user $_"
    }
}

getInput