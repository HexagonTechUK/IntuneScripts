<#
.SYNOPSIS
	PowerShell script to detect the installation version.

.DESCRIPTION
	
	This script checks the version of the application's installation
	file and reports whether the version matches, indicating success or failure.

.NOTES
    Author: Paul Gosling, Hexagon Tech
    Last Edit: 2025/02/04
    Version: 1.0
#>

# Variables (complete these):
$productName      = "TeamViewer"   #-----------------------------------------# Application name for logfile
$executablePath64 = "C:\Program Files\TeamViewer\TeamViewer.exe"   #---------# Path for 64-bit application
$executablePath32 = "C:\Program Files (x86)\TeamViewer\TeamViewer.exe"   #---# Path for 32-bit application

#Check for Win32 app
$teamviewer = Get-WmiObject -Class Win32_Product | Where-Object {$_.Name -like "*teamviewer*"}
if ($teamviewer) {
    $fileVersion = $teamviewer.Version
} else {
    #No Win32 app found - checking if 64-bit installation exists, if not, check for 32-bit.
    if (Test-Path $executablePath64) {
        $executablePath = $executablePath64
    } elseif (Test-Path $executablePath32) {
        $executablePath = $executablePath32
    } else {
        Write-Output "$productName not installed."    
        exit 0 }
} 

# Get the file version from the found executable path
$fileVersion = (Get-Item "$executablePath").VersionInfo.FileVersion
Write-Output $fileVersion
exit 0

# End of script