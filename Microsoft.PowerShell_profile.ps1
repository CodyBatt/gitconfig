
$profile_dir = Split-Path -parent $profile
$github_path = [System.Environment]::ExpandEnvironmentVariables("%USERPROFILE%\Local Settings\Application Data\GitHub\PORTAB~1\bin\")

$env:PATH += ";" + $profile_dir + "\"

if (Test-Path $github_path)
{
    $env:PATH += ";" + $github_path
}

function git-cleanup {
	$cmd = (join-path "$profile_dir" "git-cleanup.ps1")
	$expression = "'$cmd'"
	Invoke-Expression  "& $expression"
}

function mklink {     
	cmd /c mklink $args 
}

function nuget-clean ($file) {
	if( $file -eq $null )
	{
		echo "Specify the solution to clean."
		return 
	}
	echo "Cleaning solution: $file"
        if( -not (test-path $file) )
        {
		echo "Can't find file: $file"
		return
        }
	git clean -dxf
        nuget restore $file
}

echo "Installed function: git-cleanup"
echo "Installed function: mklink"
echo "Installed function: nuget-clean"