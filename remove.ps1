#This script is used to remove certain folder structure
#Developer - kujalk
#Date - 29\12\2017
#Version - 2


#function for logging time
function timestamp ($message)
{
$date=Get-Date
"$date : $message" >> $log
}

$reply= Read-Host "`n`nDid you use your Privilege Account to run this script`n  If yes press 'y' if not press 'n'"



if ( $reply -eq "y")
{
#Log location
$log= Read-Host "`nProvide a location for log Eg - [D:\Log.txt]"

timestamp "Starting work"
#First common path to folder structure
$path1="E:\Training\Files\"
set-location $path1

#Loading all user profiles in to the variable, ignoring other files
$profiles = Get-ChildItem | where {$_.Attributes -match 'Directory'}| select "Name" -ExpandProperty "Name"

	#Iterating in user profiles
	foreach ($userpro in $profiles)
	{
	#Moving to a user profile
	cd "$path1\$userpro"

		if(Test-Path ".\Software\Purpose\")
		{
		#Moving inside the user profile
		cd ".\Software\Purpose\"
		
		#Getting sub folders inside the user profiles, ignoring other files
		$subfol = @(Get-ChildItem | where {$_.Attributes -match 'Directory'}|select "Name" -ExpandProperty "Name")

		
			if ($subfol.length -eq 0)
			{
		
			timestamp  "<<Info>> : No any 'Trainx' folder under for $userpro"
			}

			else
			{
				foreach ($tem in $subfol)
				{
				cd "$path1\$userpro\Software\Purpose\$tem"
					if(Test-Path ".\cache")
					{
					####Remove cache folder######
					Remove-Item "cache" -recurse -confirm:$false
					
					timestamp "<<Info>> : 'cache' folder removed from $userpro\Software\Purpose\$tem"
					}
					else
					{
					
					timestamp "<<Info>> :  'cache' folder is not found for $userpro\Software\Purpose\$tem"
					}
				}
			}
		}

		else
		{
		
		timestamp "<<Info>> : '\Software\Purpose\' is not avaialbe for $userpro profile"
		}

	}
	
	set-location $path1
	timestamp "Everything finished!!!!"
}

else
{
write-host "Please right click the powershell windows and run as different user`nTerminating !!!!"
exit
}
