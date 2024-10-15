#Needs to run as admin
$appPackagePath = dism /Online /Get-ProvisionedAppxPackages

function removeAppPackages {
    param (
        [string]$packageName,
        [string]$displayName
    )

    try {
        if ($appPackagePath | Select-String $displayName) {
            Remove-ProvisionedAppPackage -Online -PackageName $packageName -AllUsers
            Write-Host "Removing $packageName"
        } else {
            Write-Host "Package $displayName does not exist"
        }
    }
    catch {
        Write-Host "Encountered Error: ${$_.Exception.Message}"
    }
}
#create a hashtable to list the pachages to remove 
$packages = @{
    "Clipchamp.Clipchamp" = "Clipchamp.Clipchamp_3.1.11720.0_neutral_~_yxz26nhyzhsrt"
    "Microsoft.BingNews" = "Microsoft.BingNews_4.8.11001.0_neutral_~_8wekyb3d8bbwe"
    "Microsoft.BingWeather" = "Microsoft.BingWeather_4.53.62621.0_neutral_~_8wekyb3d8bbwe"
    "Microsoft.GamingApp" = "Microsoft.GamingApp_2409.1001.5.0_neutral_~_8wekyb3d8bbwe"
    "Microsoft.MicrosoftSolitaireCollection" = "Microsoft.MicrosoftSolitaireCollection_4.20.9120.0_neutral_~_8wekyb3d8bbwe"
    "Microsoft.MixedReality.Portal" = "Microsoft.MixedReality.Portal_2000.22041.1123.0_neutral_~_8wekyb3d8bbwe"
    "Microsoft.ZuneVideo" = "Microsoft.ZuneVideo_2019.22091.10061.0_neutral_~_8wekyb3d8bbwe"
    "Microsoft.ZuneMusic" = "Microsoft.ZuneMusic_11.2408.4.0_neutral_~_8wekyb3d8bbwe"
    "Microsoft.YourPhone" = "Microsoft.YourPhone_1.24082.137.0_neutral_~_8wekyb3d8bbwe"
    "Microsoft.People" = "Microsoft.People_2021.2202.100.0_neutral_~_8wekyb3d8bbwe"
    "Microsoft.WindowsFeedbackHub" = "Microsoft.WindowsFeedbackHub_2024.715.1240.0_neutral_~_8wekyb3d8bbwe"
    "Microsoft.Xbox.TCUI" = "Microsoft.Xbox.TCUI_1.24.10001.0_neutral_~_8wekyb3d8bbwe"
    "Microsoft.XboxGameOverlay" = "Microsoft.XboxGameOverlay_1.54.4001.0_neutral_~_8wekyb3d8bbwe"
    "Microsoft.XboxGamingOverlay" = "Microsoft.XboxGamingOverlay_7.224.9031.0_neutral_~_8wekyb3d8bbwe"
    "Microsoft.XboxIdentityProvider" = "Microsoft.XboxIdentityProvider_12.115.1001.0_neutral_~_8wekyb3d8bbwe"
}

#call the function and iterate through each key value pair
foreach ($package in $packages.GetEnumerator()) {
    removeAppPackages -packageName $package.value -displayName $package.Key
}

# try {
#     if ($appPackagePath | Select-String "Clipchamp.Clipchamp") {
#         Remove-ProvisionedAppPackage -Online -PackageName "Clipchamp.Clipchamp_3.1.11720.0_neutral_~_yxz26nhyzhsrt" -AllUsers
#         Write-Host "Removing ${$_.PackageName}"
#     }
#     else {
#         Write-Host "Package does not exist"
#     }
# }
# catch {
#     Write-Host "Encountered Error: $_.Exception.Message"
# }

# try {
#     if ($appPackagePath | Select-String "Microsoft.BingNews") {
#         Remove-ProvisionedAppPackage -Online -PackageName "Microsoft.BingNews_4.8.11001.0_neutral_~_8wekyb3d8bbwe" -AllUsers
#         Write-Host "Removing ${$_.PackageName}"
#     }
#     else {
#         Write-Host "Package does not exist"
#     }
# }
# catch {
#     Write-Host "Encountered Error: $_.Exception.Message"
# }

# try {
#     if ($appPackagePath | Select-String "Microsoft.BingWeather") {
#         Remove-ProvisionedAppPackage -Online -PackageName "Microsoft.BingWeather_4.53.62621.0_neutral_~_8wekyb3d8bbwe" -AllUsers
#         Write-Host "Removing ${$_.PackageName}"
#     }
#     else {
#         Write-Host "Package does not exist"
#     }
# }
# catch {
#     Write-Host "Encountered Error: $_.Exception.Message"
# }
# try {
#     if ($appPackagePath | Select-String "Microsoft.GamingApp") {
#         Remove-ProvisionedAppPackage -Online -PackageName "Microsoft.GamingApp_2409.1001.5.0_neutral_~_8wekyb3d8bbwe" -AllUsers
#         Write-Host "Removing ${$_.PackageName}"
#     }
#     else {
#         Write-Host "Package does not exist"
#     }
# }
# catch {
#     Write-Host "Encountered Error: $_.Exception.Message"
# }
# try {
#     if ($appPackagePath | Select-String "Microsoft.MicrosoftSolitaireCollection") {
#         Remove-ProvisionedAppPackage -Online -PackageName "Microsoft.MicrosoftSolitaireCollection_4.20.9120.0_neutral_~_8wekyb3d8bbwe" -AllUsers
#         Write-Host "Removing ${$_.PackageName}"
#     }
#     else {
#         Write-Host "Package does not exist"
#     }
# }
# catch {
#     Write-Host "Encountered Error: $_.Exception.Message"
# }
# try {
#     if ($appPackagePath | Select-String "Microsoft.MixedReality.Portal") {
#         Remove-ProvisionedAppPackage -Online -PackageName "Microsoft.MixedReality.Portal_2000.22041.1123.0_neutral_~_8wekyb3d8bbwe" -AllUsers
#         Write-Host "Removing ${$_.PackageName}"
#     }
#     else {
#         Write-Host "Package does not exist"
#     }
# }
# catch {
#     Write-Host "Encountered Error: $_.Exception.Message"
# }
# try {
#     if ($appPackagePath | Select-String "Microsoft.ZuneVideo") {
#         Remove-ProvisionedAppPackage -Online -PackageName "Microsoft.ZuneVideo_2019.22091.10061.0_neutral_~_8wekyb3d8bbwe" -AllUsers
#         Write-Host "Removing ${$_.PackageName}"
#     }
#     else {
#         Write-Host "Package does not exist"
#     }
# }
# catch {
#     Write-Host "Encountered Error: $_.Exception.Message"
# }
# try {
#     if ($appPackagePath | Select-String "Microsoft.ZuneMusic") {
#         Remove-ProvisionedAppPackage -Online -PackageName "Microsoft.ZuneMusic_11.2408.4.0_neutral_~_8wekyb3d8bbwe" -AllUsers
#         Write-Host "Removing ${$_.PackageName}"
#     }
#     else {
#         Write-Host "Package does not exist"
#     }
# }
# catch {
#     Write-Host "Encountered Error: $_.Exception.Message"
# }
# try {
#     if ($appPackagePath | Select-String "Microsoft.YourPhone") {
#         Remove-ProvisionedAppPackage -Online -PackageName "Microsoft.YourPhone_1.24082.137.0_neutral_~_8wekyb3d8bbwe" -AllUsers
#         Write-Host "Removing ${$_.PackageName}"
#     }
#     else {
#         Write-Host "Package does not exist"
#     }
# }
# catch {
#     Write-Host "Encountered Error: $_.Exception.Message"
# }
# try {
#     if ($appPackagePath | Select-String "Microsoft.People") {
#         Remove-ProvisionedAppPackage -Online -PackageName "Microsoft.People_2021.2202.100.0_neutral_~_8wekyb3d8bbwe" -AllUsers
#         Write-Host "Removing ${$_.PackageName}"
#     }
#     else {
#         Write-Host "Package does not exist"
#     }
# }
# catch {
#     Write-Host "Encountered Error: $_.Exception.Message"
# }
# try {
#     if ($appPackagePath | Select-String "Microsoft.WindowsFeedbackHub") {
#         Remove-ProvisionedAppPackage -Online -PackageName "Microsoft.WindowsFeedbackHub_2024.715.1240.0_neutral_~_8wekyb3d8bbwe" -AllUsers
#         Write-Host "Removing ${$_.PackageName}"
#     }
#     else {
#         Write-Host "Package does not exist"
#     }
# }
# catch {
#     Write-Host "Encountered Error: $_.Exception.Message"
# }
# try {
#     if ($appPackagePath | Select-String "Microsoft.Xbox.TCUI") {
#         Remove-ProvisionedAppPackage -Online -PackageName "Microsoft.Xbox.TCUI_1.24.10001.0_neutral_~_8wekyb3d8bbwe" -AllUsers
#         Write-Host "Removing ${$_.PackageName}"
#     }
#     else {
#         Write-Host "Package does not exist"
#     }
# }
# catch {
#     Write-Host "Encountered Error: $_.Exception.Message"
# }
# try {
#     if ($appPackagePath | Select-String "Microsoft.XboxGameOverlay") {
#         Remove-ProvisionedAppPackage -Online -PackageName "Microsoft.XboxGameOverlay_1.54.4001.0_neutral_~_8wekyb3d8bbwe" -AllUsers
#         Write-Host "Removing ${$_.PackageName}"
#     }
#     else {
#         Write-Host "Package does not exist"
#     }
# }
# catch {
#     Write-Host "Encountered Error: $_.Exception.Message"
# }
# try {
#     if ($appPackagePath | Select-String "Microsoft.XboxGameOverlay") {
#         Remove-ProvisionedAppPackage -Online -PackageName "Microsoft.XboxGamingOverlay_7.224.9031.0_neutral_~_8wekyb3d8bbwe" -AllUsers
#         Write-Host "Removing ${$_.PackageName}"
#     }
#     else {
#         Write-Host "Package does not exist"
#     }
# }
# catch {
#     Write-Host "Encountered Error: $_.Exception.Message"
# }
# try {
#     if ($appPackagePath | Select-String "Microsoft.XboxGameOverlay") {
#         Remove-ProvisionedAppPackage -Online -PackageName "Microsoft.XboxGamingOverlay_7.224.9031.0_neutral_~_8wekyb3d8bbwe" -AllUsers
#         Write-Host "Removing ${$_.PackageName}"
#     }
#     else {
#         Write-Host "Package does not exist"
#     }
# }
# catch {
#     Write-Host "Encountered Error: $_.Exception.Message"
# }
# try {
#     if ($appPackagePath | Select-String "Microsoft.XboxIdentityProvider") {
#         Remove-ProvisionedAppPackage -Online -PackageName "Microsoft.XboxIdentityProvider_12.115.1001.0_neutral_~_8wekyb3d8bbwe" -AllUsers
#         Write-Host "Removing ${$_.PackageName}"
#     }
#     else {
#         Write-Host "Package does not exist"
#     }
# }
# catch {
#     Write-Host "Encountered Error: $_.Exception.Message"
# }


