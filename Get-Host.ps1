<#
.SYNOPSIS
    {Write a brief synopsis of this script}

.DESCRIPTION
   {Write a description of this script and it's function.
    Include an prerequisites that are required and what to expect post deployment}

.PARAMETER 
    {Write any parameters or expected values for this script}

.OUTPUTS
    {Write the output paths for the log file or message logs}

.NOTES
    File Name : {Get-HostName.ps1}  
    Author    : Paul Gosling, Hexagon Technology Services  
    Created   : 2025-05-06  
    Version   : 1.0 - Initial Script  
     Requires :  

.EXAMPLE
    {Write and example value input and expected output for this script}   
    {$value} = "{value}"

    Example output:
    "Values present" or "Values missing"
#>

# Variables (complete these):
$deployType  = "Get"    #----------------------------------------------------------# Deployment type: Install, Upgrade, Removal   
$productName = "HostName"   #------------------------------------------------------# Application name or function for logfile   
$logFileName = Join-Path $env:ProgramData "_MEM\$deployType-$productName.log"  #---# Path to script logfile   

# Create the log file if it doesn't exist
if (-not (Test-Path $logFileName)) {
    New-Item -Path $logFileName -ItemType File -Force
}

# Function to log messages (to both file and Intune output)
function Write-Log {
    param (
        [string]$Message
    )
    $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm")
    "$timestamp | $Message" | Out-File -FilePath $logFileName -Append
    Write-Output "$timestamp | $Message"
}

Write-Log $env:computername

# End of script
