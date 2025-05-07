<#
.SYNOPSIS
    PowerShell script to detect the installation of Chrome and Edge Okta Plugin extensions

.DESCRIPTION
   This script checks the application data folders for the presence of the Chrome
   and Edge Okta Plugin extensions.

.NOTES
    Author: Paul Gosling, Persimmon Homes
    Last Edit: 2024-11-01
    Version: 1.0
#>

# Variables (complete these):
$deployType     = "Detect"    #-----------------------------------------------------------# Deployment type: Install, Upgrade, Removal
$productName    = "BrowserExtensions"   #-------------------------------------------------# Application name for logfile
$logFileName    = Join-Path $env:ProgramData "PH\$deployType-$productName.log"  #---------# Path to app logfile

# Start logging
Start-Transcript -Path $logFileName

# Extension IDs
$chromeExtensionId = "glnpjglilkicbckjpbgcfkogebgllemb"  # Replace with actual Chrome extension ID
$edgeExtensionId = "ncoafaeidnkeafiehpkfoeklhajkpgij"    # Replace with actual Edge extension ID

# Function to check if an extension is installed for a given browser
function Check-ExtensionInstalled {
    param (
        [string]$browserName,
        [string]$extensionId
    )
    
    $userProfiles = Get-ChildItem "C:\Users"
    foreach ($profile in $userProfiles) {
        $extensionPath = ""

        if ($browserName -eq "Chrome") {
            $extensionPath = "C:\Users\$($profile.Name)\AppData\Local\Google\Chrome\User Data\Default\Extensions\$extensionId"
        } elseif ($browserName -eq "Edge") {
            $extensionPath = "C:\Users\$($profile.Name)\AppData\Local\Microsoft\Edge\User Data\Default\Extensions\$extensionId"
        }

        if (Test-Path $extensionPath) {
            return $true
        }
    }
    return $false
}

# Check for extensions
$chromeInstalled = Check-ExtensionInstalled -browserName "Chrome" -extensionId $chromeExtensionId
$edgeInstalled = Check-ExtensionInstalled -browserName "Edge" -extensionId $edgeExtensionId

# Determine exit code
if ($chromeInstalled -or $edgeInstalled) {
    Write-Host "At least one extension is installed."
    exit 1  # Exit code 1 if any extension is found
} else {
    Write-Host "No extensions are installed."
    exit 0  # Exit code 0 if no extensions are found

}

# Conclude logging
Stop-Transcript