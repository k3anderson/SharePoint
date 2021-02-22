<#
.SYNOPSIS
Add a colour theme to SharePoint
.INPUTS
SharePoint admin URL
Colour theme name
Colour Palette
.OUTPUTS
None
.NOTES
Version:                    1.0
Creation Date:              26 Sep 2020
Required Module:            SharePointOnlinePowerShell
#>

$adminSiteUrl = "https://<TENANT>-admin.sharepoint.com"
$themeName = "THEME NAME"

Connect-SPOService $adminSiteUrl

#Add in your Hex Codes
$colourPalette = @{
    "themePrimary" = "#<HEXCODE>";
    "themeLighterAlt" = "#<HEXCODE>";
    "themeLighter" = "#<HEXCODE>";
    "themeLight" = "#<HEXCODE>";
    "themeTertiary" = "#<HEXCODE>";
    "themeSecondary" = "#<HEXCODE>";
    "themeDarkAlt" = "#<HEXCODE>";
    "themeDark" = "#<HEXCODE>";
    "themeDarker" = "#<HEXCODE>";
    "neutralLighterAlt" = "#<HEXCODE>";
    "neutralLighter" = "#<HEXCODE>";
    "neutralLight" = "#<HEXCODE>";
    "neutralQuaternaryAlt" = "#<HEXCODE>";
    "neutralQuaternary" = "#<HEXCODE>";
    "neutralTertiaryAlt" = "#<HEXCODE>";
    "neutralTertiary" = "#<HEXCODE>";
    "neutralSecondary" = "#<HEXCODE>";
    "neutralPrimaryAlt" = "#<HEXCODE>";
    "neutralPrimary" = "#<HEXCODE>";
    "neutralDark" = "#<HEXCODE>";
    "black" = "#000000";
    "white" = "#ffffff";
    "accent" = "#<HEXCODE>";
    "backgroundOverlay" = "#<HEXCODE>";
}

#Add theme to SharePoint
Add-SPOTheme -Name $themeName -Palette $colourPalette -IsInverted:$false -Overwrite