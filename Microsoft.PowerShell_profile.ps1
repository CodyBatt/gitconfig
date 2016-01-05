
$profile_dir = Split-Path -parent $profile
$github_path = [System.Environment]::ExpandEnvironmentVariables("%USERPROFILE%\Local Settings\Application Data\GitHub\PORTAB~1\bin\")
$sublime_path = "C:\Program Files (x86)\Microsoft VS Code\code.exe"



if( (test-path $sublime_path) )
{
    set-alias sublime $sublime_path
    set-alias vi sublime
}
else {
    write-warning "Can't find sublime."
}


$env:PATH += ";" + $profile_dir + "\"

if (Test-Path $github_path)
{
    $env:PATH += ";" + $github_path
}

$env:PSModulePath = $env:PSModulePath + ";$PsScriptRoot\modules"
import-module csb-util

echo "Installed csb-util: "
get-command -module csb-util

# Make CD work like Unix
$global:LastLocation = $env:HOME
function ChangeDirectory ($Path) {
    if($Path -eq "-") {
        Set-Location $global:LastLocation
    }
    elseif ($Path) {
        $global:LastLocation = (Get-Location).Path
        Set-Location $Path
    }
    else { 
        Set-Location $env:HOME
    }
}

Remove-Item alias:cd
set-alias cd ChangeDirectory -Option AllScope