#Single User or Multiple
function getInput {
    $choice = Read-Host "Will this be for a [1]Single User or [2]Multiple Users?"

    #Option 1
    if($choice -eq 1) {
        do {
            $userName = Read-Host "Please enter the username of the user to update: "
            try {
                $knownUser = Get-ADUser -Identity $userName
                if (-not $knownUser) {
                    Write-Host "No user exist with that username. Please verify your spelling and try again."
                }
            }
            catch {
                $knownUser = $null
            }
        } while (
            -not $knownUser
        )
        $phoneNumber = Read-Host "Please enter the users phone number"
        processUsers $userName $phoneNumber
    }

    #Option 2
    if($choice -eq 2) {
        do {
            $filePath = Read-Host "Please enter the filepath to the csv"
            $fileName = "TestAddUsersPhoneToAD"

            try {
                if(-not (Test-Path $filePath)) {
                    Write-Host "File Path does not exist. Check your spelling and location and try again"
                }
            }
            catch {
                $filePath = $null
            }
        } while (
            -not (Test-Path $filePath)
        )
    }
    #Import CSV - Option 2
    try {
        $userToUpdate = Import-Csv ($filePath + "\" + $fileName)
        forEach($user in $userToUpdate) {
            $userName = $user.name
            $phoneNumber = $user.phone
            processUsers $userName $phoneNumber
        }
    }
    catch {
        Write-Host "Error occurred: $_"
    }
}

#Function to process the imported/eneterd info and update the phone number
function processUsers {
    param (
        [string]$userName,
        [int]$phoneNumber
    )
    
    try {
        Set-ADUser -Identity $userName -OfficePhone $phoneNumber
        Write-Host "Successfully updated user: $userName with phone number: $phoneNumber"
    }
    catch {
        Write-Host "An Error occurred: $_"
    }
}

