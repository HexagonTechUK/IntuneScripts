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
    File Name : {scriptName.ps1}  
    Author    : Paul Gosling, Hexagon Technology Services  
    Created   : {YYYY-MM-DD}  
    Version   : 1.0 - Initial Script  
     Requires  : {Write any requirements or prerequisites for this script}  

.EXAMPLE
    {Write and example value input and expected output for this script}   
    {$value} = "{value}"

    Example output:
    "Values present" or "Values missing"
#>

# Variables (complete these):
$deployType  = "{deployType}"    #-----------------------------------------------# Deployment type: Install, Upgrade, Removal   
$productName = "{productName}"   #-----------------------------------------------# Application name or function for logfile   
$logFileName = Join-Path $env:ProgramData "PH\$deployType-$productName.log"  #---# Path to script logfile   

# Create the log file if it doesn't exist
if (-not (Test-Path $logFileName)) {
    New-Item -Path $logFileName -ItemType File -Force
}

# Function to log messages (to both file and Intune output)
function Log-Message {
    param (
        [string]$Message
    )
    $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm")
    "$timestamp | $Message" | Out-File -FilePath $logFileName -Append
    Write-Output "$timestamp | $Message"
}

<# Insert Code Here #>

# End of script
