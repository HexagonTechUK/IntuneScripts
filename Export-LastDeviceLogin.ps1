<#
.SYNOPSIS
    Exports a list of all Active Directory computers and their last logon dates to a CSV file.

.DESCRIPTION
   This script queries Active Directory for all computer objects and retrieves their names and last logon dates.
   The information is exported to a CSV file for reporting or auditing purposes.

.OUTPUT
    CSV file located at C:\AD_Devices_LastLogon.csv containing:
        - ComputerName
        - LastLogonDate

.NOTES
    File Name : Export-LastDeviceLogin.ps1  
    Author    : Paul Gosling, Hexagon Technology Services  
    Created   : 2025-05-08  
    Version   : 1.0 - Initial Script  
     Requires : Active Directory module
                Appropriate AD permissions to query computer objects  

#>

# Define the path for the output CSV file
$outputCsv = "C:\AD_Devices_LastLogon.csv"

# Import the Active Directory module
Import-Module ActiveDirectory

# Query Active Directory for all computer objects
$computers = Get-ADComputer -Filter * -Property Name, LastLogonDate

# Create an array to hold the results
$results = @()

# Loop through each computer object and gather the necessary information
foreach ($computer in $computers) {
    # Create a custom object with the computer name and last logon date
    $result = [PSCustomObject]@{
        ComputerName = $computer.Name
        LastLogonDate = $computer.LastLogonDate
    }
    # Add the custom object to the results array
    $results += $result
}

# Export the results to a CSV file
$results | Export-Csv -Path $outputCsv -NoTypeInformation

Write-Output "Export completed successfully. The file is located at: $outputCsv"

# End of script
