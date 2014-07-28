$profile_dir = Split-Path -parent $profile
$modules_dir = (join-path $profile_dir "modules")
$csb_dir = (join-path $modules_dir "csb-util")

echo "Installing..."

$dirs = @(
    $profile_dir,
    $modules_dir,
    $csb_dir
)

$dirs | % {
    if(-not (test-path $_))
    {
        mkdir $_ > $null
    }
}

$files = @{
 "git-cleanup.ps1" = $profile_dir; 
 "Microsoft.PowerShell_profile.ps1" = $profile_dir;
 "csb-util.psm1" = $csb_dir
}


echo $files
$files.Keys | % { 
    $f = $_
    $d = $files.Item($_)
    echo "Copying $f to $d..." 
    copy (join-Path $PSScriptRoot $f) $d 
}

echo ""
write-Host -NoNewline "Now reload your profile by running: "
write-Host  -ForegroundColor "yellow" ". `$profile"