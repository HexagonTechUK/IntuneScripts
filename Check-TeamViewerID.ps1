<#
.SYNOPSIS
	PowerShell script to detect the TeamViewer ID.

.DESCRIPTION
	
	This script checks the version of the application's installation
	file and reports whether the TeamViewer ID, indicating success or failure.

.NOTES
    Author: Paul Gosling, Hexagon Tech
    Last Edit: 2025/02/04
    Version: 1.0
#>

# Define the registry path and value name
$regPath = "HKLM:\SOFTWARE\TeamViewer"
$valueName = "ClientID"

# Check if the registry key and value exist
if (Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue) {
    # Registry key exists, exit with code 1
    Write-Output "Installed."
    Exit 1
} else {
    # Registry key does not exist, exit with code 0
    Write-Output "Not Installed."
    Exit 0
}

# End of script