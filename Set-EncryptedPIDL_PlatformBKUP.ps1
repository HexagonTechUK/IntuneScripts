<#
.SYNOPSIS
    Sets the screensaver slide show folder

.DESCRIPTION
	This scripts sets the EncryptedPIDL registry path to C:\ProgramData\PH\Screensavers 
	for use with the C:\Windows\System32\PhotoScreensaver.scr file.

.EXAMPLE
    .\Set-EncryptedPIDL.ps1

.NOTES
    Author: Paul Gosling, Persimmon Homes
    Last Edit: 2024-04-19
    Version: 1.0
#>

# Set working directory to script root
	Set-Location -Path $PSScriptRoot

	# Obtain install command line
	$productName = "EncryptedPIDL-Platform"

	# Start transcript in PH folder
	$transcriptLogFilename = "$env:ProgramData\PH\Update-$productName.log"
	Start-Transcript -Path $transcriptLogFilename

    New-Item -Path "HKCU:\Software\Microsoft\Windows Photo Viewer\Slideshow\Screensaver"

	# Set Encrypted path to file location
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows Photo Viewer\Slideshow\Screensaver" -Name 'EncryptedPIDL' -Value "FAAfUOBP0CDqOmkQotgIACswMJ0ZAC9DOlwAAAAAAAAAAAAAAAAAAAAAAAAAeAAx

AAAAAAA+WHNnEQBVc2VycwBkAAkABADvvodPd0g/WKx2LgAAAPMFAAAAAAEAAAAA

AAAAAAA6AAAAAAAvtI0AVQBzAGUAcgBzAAAAQABzAGgAZQBsAGwAMwAyAC4AZABs

AGwALAAtADIAMQA4ADEAMwAAABQAfAAxAAAAAAA/WPN2EQBQdWJsaWMAAGYACQAE

AO++h0/bST9Y83YuAAAAJAYAAAAAAQAAAAAAAAAAADwAAAAAANOxKAFQAHUAYgBs

AGkAYwAAAEAAcwBoAGUAbABsADMAMgAuAGQAbABsACwALQAyADEAOAAxADYAAAAW

AF4AMQAAAAAAP1jzdhAAV0FMTFBBfjEAAEYACQAEAO++P1jzdj9Y83YuAAAAt68A

AAAAAgAAAAAAAAAAAAAAAAAAAFoA+QBXAGEAbABsAHAAYQBwAGUAcgBzAAAAGAAA

AA==" -Force

    # Turn on the screensaver shuffle pattern
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows Photo Viewer\Slideshow\Screensaver" -Name 'Shuffle' -Value 1

    # Set the screensaver speed to slow
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows Photo Viewer\Slideshow\Screensaver" -Name 'Speed' -Value 0
	
	# Stop transcript log
	Stop-Transcript