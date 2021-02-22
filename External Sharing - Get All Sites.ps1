<#
.SYNOPSIS
Use script to get the details and sharing policy of sites
Requires uploading of certificate to an Azure App that has been given write access to all SharePoint sites
Get-PnPTenantSite - https://docs.microsoft.com/en-us/powershell/module/sharepoint-pnp/get-pnptenantsite?view=sharepoint-ps
.INPUTS
$SPCertificate  = Certificate Location
$SPCertPass     = Certificate Password
$clientID       = Azure App ID that contains your delegated permissions
$Tenant         = "<tenant>.onmicrosoft.com"
$FilterURL      = Filter URL to fine tune your targeted group of sites
$AdminURL       = SharePoint admin URL
.OUTPUTS
$ReportOutput   = CSV of all sites that match the filters
.NOTES
Version:                    1.0
Author:                     Kyle Anderson
Creation Date:              26 Sep 2020
Required Module:            SharePointPnPPowerShellOnline
SharingCapability Options:  Disabled, ExistingExternalUserSharingOnly, ExternalUserAndGuestSharing, ExternalUserAndGuestSharing
#>

$SPCertificate = "C:\<Location>\<Certificate>.pfx"
$SPCertPass = "<Certificate Password>"
$clientID = "<Azure App Client ID>"
$Tenant = "<tenant>.onmicrosoft.com"
$FilterURL = "Url -like '<tenant>.sharepoint.com/sites/'"

$AdminURL = "https://<tenant>-admin.sharepoint.com"
$ReportOutput = "C:\Users\Desktop\ExternalSharingSites.csv"

#Connect to SharePoint site collection
Connect-PnPOnline -ClientId $clientID -CertificatePath $SPCertificate -CertificatePassword (ConvertTo-SecureString -AsPlainText $SPCertPass -Force) -Url $AdminURL  -Tenant $Tenant
#Get the Url, Title, Template and SharingCapability of all sites that do not have sharing disabled
$SiteCollection = Get-PnPTenantSite -Filter $FilterURL | Where-Object SharingCapability -ne "Disabled" | select-object Url, Title, Template, SharingCapability
Disconnect-PnPOnline

$SiteCollection | Export-csv $ReportOutput -NoTypeInformation 
Write-host "Report Generated to $ReportOutput" -f Green
