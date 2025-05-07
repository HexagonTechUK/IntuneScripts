<#
.SYNOPSIS
	PowerShell script to detect the presence of ODBC values.

.DESCRIPTION
	
	This script detects the installation of ODBC settings.

.NOTES
    Author: Paul Gosling, Hexagon Tech
    Last Edit: 2025/02/04
    Version: 1.0
#>

# Define the registry path and value name
$regPath = "HKLM:\SOFTWARE\ODBC\ODBC.INI\Partner"
$regValueName = "Database"
$dbValueName  = "{dsnName}"

# Check if the registry key exists
if (Test-Path $regPath) {
    # Get the value of the "Database" registry key
    $dbValue = Get-ItemProperty -Path $regPath -Name $regValueName

    # Check if the value is present
    if ($dbValue.$regValueName -ieq "$dbValueName") {
        # Return exit code 0 if the value is $dbValueName
        Write-Output "ODBC values present"
        #exit 0
    } else {
        # Return exit code 1 if the value is not $dbValueName
        Write-Output "ODBC values missing"
        #exit 1
    }
} else {
    # Return exit code 1 if the registry key does not exist
    Write-Output "ODBC values missing"
    #exit 1
}

# End of script
