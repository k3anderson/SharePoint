<#
.SYNOPSIS
Assign user as SharePoint admin to all SharePoint sites
.INPUTS
SharePoint admin site url
Admin username
.OUTPUTS
None
.NOTES
Version:          1.0
Creation Date:    26 Sep 2020
Required Module:  SharePointOnlinePowerShell
#>

#Admin URL
$URL = "https://[Tenant]-admin.sharepoint.com/"
#User being added to site collection as admin
$SPAdminName = "[username]@[tenant]" 

#Connect to SharePoint Online using Admin credentials
Connect-SPOService -url $URL

#Get all SharePoint sites
$Sites = Get-SPOSite -Limit All

Foreach ($Site in $Sites)
{
  Set-SPOUser -site $Site -LoginName $SPAdminName -IsSiteCollectionAdmin $true #false
}