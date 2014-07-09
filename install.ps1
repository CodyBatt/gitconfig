$profile_dir = Split-Path -parent $profile

echo "Installing..."

if ( -not (test-Path $profile_dir ) )
{
	mkdir $profile_dir > $null
}

$files = @(
 "git-cleanup.ps1", 
 "Microsoft.PowerShell_profile.ps1"
)


echo $files
$files | % { copy (join-Path $PSScriptRoot $_) $profile_dir }

echo ""
write-Host -NoNewline "Now reload your profile by running: "
write-Host  -ForegroundColor "yellow" ". `$profile"