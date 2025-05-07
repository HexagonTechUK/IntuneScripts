<#
.SYNOPSIS
    Retrieves data from InTune, including deviceName and registeredUser.

.DESCRIPTION
   This PowerShell script queries the Intune API to retrieve managed device information.
   It iterates through all pages of device data, if pagination is necessary, and accumulates the results.
   Finally, it exports the retrieved device details, including device names and associated registered users
   to a CSV file for further analysis or reporting.

.NOTES
    File Name : Get-MgDeviceManagementDetectedApp.ps1  
    Author    : Paul Gosling, Hexagon Technology Services  
    Created   : 2025-05-08  
    Version   : 1.0 - Initial Script  
     Requires :

.PARAMETER 
    {Write any parameters or expected values for this script}

.OUTPUTS
    Outputs all detected apps to C:\detectedApps.csv
#>

# Variables (complete these):
$clientId = "{clientID}"
$clientSecret = "{clientSecret}"
$tenantId = "{tenantId}"
$tokenUrl = "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token"

    # Construct the body of the request
    $body = @{
        client_id     = $clientId
        scope         = "https://graph.microsoft.com/.default"
        client_secret = $clientSecret
        grant_type    = "client_credentials"
    }

    # Get the OAuth 2.0 access token
    $tokenResponse = Invoke-RestMethod -Uri $tokenUrl -Method Post -Body $body

    # Extract the access token from the response
    $accessToken = $tokenResponse.access_token

    # Define the headers with the access token
    $headers = @{
        Authorization = "Bearer $accessToken"
    }

    # Define the base URL for Microsoft Graph API
    $baseUrl = "https://graph.microsoft.com/v1.0"

    # Fetch AD user details
    #$ad_details = Get-ADUser -Identity $p_samaccount -Properties "LastLogonDate"

    # Fetch Intune managed devices from all pages
    $intune_devices = @()
    $url = "$baseUrl/deviceManagement/detectedApps"
    do {
        $response = Invoke-RestMethod -Uri $url -Headers $headers
        $intune_devices += $response.value
        $url = $response.'@odata.nextLink'
    } while ($null -ne $url)

    # Export Intune device details to CSV
    $intune_devices | Select-Object * | Export-Csv -Path "C:\detectedApps.csv" -NoTypeInformation
	
# End of script

