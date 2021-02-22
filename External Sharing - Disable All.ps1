<#
.SYNOPSIS
Use script to turn off external sharing on SharePoint site collection
Requires uploading of certificate to an Azure App that has been given write access to all SharePoint sites
Set-PnPTenantSite - https://docs.microsoft.com/en-us/powershell/module/sharepoint-pnp/set-pnptenantsite?view=sharepoint-ps
.INPUTS
$SPCertificate  = Certificate Location
$SPCertPass     = Certificate Password
$clientID       = Azure App ID that contains your delegated permissions
$Tenant         = "<tenant>.onmicrosoft.com"
$FilterURL      = Filter URL to fine tune your targeted group of sites
$AdminURL       = SharePoint admin URL
.OUTPUTS
None - potential for you to add error log output
.NOTES
Version:        1.0
Author:         Kyle Anderson
Creation Date:  26 Sep 2020
Required Module: SharePointPnPPowerShellOnline

Sharing Options: Disabled, ExistingExternalUserSharingOnly, ExternalUserAndGuestSharing, ExternalUserAndGuestSharing

#>

$SPCertificate = "C:\<Location>\<Certificate>.pfx"
$SPCertPass = "<Certificate Password>"
$clientID = "<Azure App Client ID>"
$Tenant = "<tenant>.onmicrosoft.com"
$FilterURL = "Url -like '<tenant>.sharepoint.com/sites/'"

$AdminURL = "https://<tenant>-admin.sharepoint.com"

#Connect to SharePoint site collection
Connect-PnPOnline -ClientId $clientID -CertificatePath $SPCertificate -CertificatePassword (ConvertTo-SecureString -AsPlainText $SPCertPass -Force) -Url $AdminURL -Tenant $Tenant
#Get all sites where the sharing setting is not disabled
$SiteCollection = Get-PnPTenantSite -Filter $FilterURL | Where-Object SharingCapability -ne "Disabled"

foreach ($Site in $SiteCollection) {
    
    #Disable external Sharing of all SharePoint sites
    Set-PnPTenantSite -Url $SiteUrl -Sharing Disabled #"Only people in your organization"

}

Disconnect-PnPOnline
