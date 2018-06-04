<#
	This script adds a list of computers to a SCCM device collection.
	Modified from some code I found in our repository
#>

# Utilizes our site path with the SCCM Powershell module
$SCCMSitePath =  #site path goes here ours is "INSTITUTION:"
Import-Module (Join-Path $(Split-Path $env:SMS_ADMIN_UI_PATH) ConfigurationManager.psd1)
Set-Location $SCCMSitePath

# Hide errors. Comment this line out to see errors
#$ErrorActionPreference = 'silentlycontinue'

# Set these variables
$TextFile = #where the list of computers is
$CollectionID = # get the collection ID


# Get the computer list, run through each computer and add it to the collection.

$ComputerList = Get-Content $TextFile

Foreach($Computer in $ComputerList)
{
	Write-Host $Computer -ForegroundColor Green
	try{Add-CMDeviceCollectionDirectMembershipRule -CollectionID $CollectionID -ResourceId $(Get-CMDevice -Name $Computer).ResourceID}
	catch{ Write-Host -Foreground Magenta "Already Added or Not Existent" }
}

Write-Host "Complete" -Foreground Red -Background black