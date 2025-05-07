<#
.SYNOPSIS
    Copies all the DSREG logs from the devices in a list to a folder in a central location. 

.DESCRIPTION
    This script copies the DSREGCMD status logs files from C:\ProgramData\_MEM to a C:\Admins\DSREG_Logs\Logs. 
    The script should be excecuted on a device with elevated access, usually a domain controller, and sources
    the devices from a text file in C:\temp\devices.txt

.NOTES
    Author: Paul Gosling, Hexagon Tech
    Last Edit: 2024-05-02
    Version: 1.1
#>

# Define the path to the text file containing device names
$DeviceNamesFile = "C:\Admins\DSREG_Logs\devices.txt"

# Read device names from the text file
$DeviceNames = Get-Content $DeviceNamesFile

# Specify the base domain for the source path
$BaseSourceDomain = "psn.persimmonhomes.net"

# Specify the destination folder where the log files will be copied
$DestinationFolder = "C:\Admins\DSREG_Logs\Logs"

# Loop through each device name
foreach ($DeviceName in $DeviceNames) {
    # Construct the source folder path using the device name and base source domain
    $SourceFolder = "\\$DeviceName.$BaseSourceDomain\c$\programdata\_MEM"
    
    # Construct the source file path
    $SourceFile = Join-Path -Path $SourceFolder -ChildPath "dsregcmd_status.txt"
    
    # Construct the destination file path
    $DestinationFile = Join-Path -Path $DestinationFolder -ChildPath "$DeviceName-status.log"
    
    # Copy the source file to the destination folder
    Copy-Item -Path $SourceFile -Destination $DestinationFile -Force
}

# End of script