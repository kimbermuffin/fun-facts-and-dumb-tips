# Get rid of some damn Windows 10 apps on command
# Probably copied from somewhere and modified slightly, i'm sorry i didn't cite my code


$apps = @('3DBuilder', 'BingWeather', 'Messaging', 'MicrosoftOfficeHub', 
		 'MicrosoftSolitaireCollection', 'People', 'SkypeApp', 'windowscommunicationsapps', 
		 'WindowsFeedbackHub', 'WindowsMaps', 'XboxApp', 'XboxIdentityProvider', 
		 'ZuneMusic', 'ZuneVideo', 'Getstarted', 'OneConnect', 'WindowsStore', 'Getstarted')

write-host 'Removing Contact Support'
Get-WindowsCapability -online | ? {$_.Name -like '*ContactSupport*'} | Remove-WindowsCapability –online

write-host 'Removing Quick Assist'
Get-WindowsCapability -online | ? {$_.Name -like '*QuickAssist*'} | Remove-WindowsCapability –online

foreach ($app in $apps){
	Write-Host "Removing $app"
	Get-appxprovisionedpackage -online | where-object {$_.displayname –like "*$app*"} | remove-appxprovisionedpackage –online
	Write-Verbose -Message "$$"
}