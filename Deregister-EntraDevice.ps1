<#
.SYNOPSIS
   Deregister Hybrid AAD Device
.DESCRIPTION
   Install PowerShell AzureAD Module
.EXAMPLE
   Created by Paul Gosling, Hexagon Tech 12/03/2024
#>

Start-Process -FilePath "dsregcmd" -ArgumentList "/leave" -Verb RunAs

# End of script