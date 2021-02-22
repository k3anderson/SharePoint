<#
.SYNOPSIS
Get all SharePoint lists in all SharePoint sites
Requires uploading of certificate to an Azure App that has been given write access to all SharePoint sites
.INPUTS
Certificate location path - ".pfx"
Certificate Password
Azure App Client ID
Tenant
Filter URL
Admin URL
CSV Path
.OUTPUTS
CSV of all lists
.NOTES
Version:            1.0
Author:             Kyle Anderson
Creation Date:      20 Sep 2020
Required Module:    SharePointPnPPowerShellOnline
#>

$SPCertificate = "C:\Users\Desktop\CertPFX.pfx"
$SPCertPass = "<Your Password>"
$clientID = "<Client ID>"
$Tenant = "<Tenant>"
$FilterURL = "Url -like 'https://<Tenant>.sharepoint.com/sites/'"
$AdminURL = "https://<Tenant>-admin.sharepoint.com"
$CSVPath = "C:\Users\Desktop\SharePointList.csv"
$SPLists = @()

#Connect to PnP online
Connect-PnPOnline -ClientId $clientID -CertificatePath $SPCertificate -CertificatePassword (ConvertTo-SecureString -AsPlainText $SPCertPass -Force) -Url $AdminURL  -Tenant $Tenant

#Get all SharePoint sites
$SiteCollection = Get-PnPTenantSite -Filter $FilterURL
#Disconnect from PnP to remove certificate from c:\ProgramData\Microsoft\Crypto\RSA\MachineKeys
Disconnect-PnPOnline

Write-Host $SiteCollection.Count

Foreach ($Site in $SiteCollection) {

    #Connect to each site in site collection
    Connect-PnPOnline -ClientId $clientID -CertificatePath $SPCertificate -CertificatePassword (ConvertTo-SecureString -AsPlainText $SPCertPass -Force) -Url $Site.Url -Tenant $Tenant
    $BuildArray = Get-PnPList | Select-Object Title, Description, ItemCount, Created, IsPrivate, BaseTemplate, BaseType

    #Add site details to the array of lists
    $BuildArray | Add-Member -MemberType NoteProperty "SiteName" -Value $Site.Title
    $BuildArray | Add-Member -MemberType NoteProperty "SiteURL" -Value $Site.Url
    $BuildArray | Add-Member -MemberType NoteProperty "Template" -Value $Site.Template

    $SPLists += $BuildArray
    Disconnect-PnPOnline

}

#Export List data to CSV
$SPLists | Export-Csv -Path $CSVPath -Force -NoTypeInformation
Write-host -f Green "CSV created and exported"