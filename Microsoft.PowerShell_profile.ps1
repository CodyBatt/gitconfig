
$profile_dir = Split-Path -parent $profile
$github_path = [System.Environment]::ExpandEnvironmentVariables("%USERPROFILE%\Local Settings\Application Data\GitHub\PORTAB~1\bin\")
$sublime_path = "C:\Program Files\Sublime Text 2\sublime_text.exe"

if( (test-path $sublime_path) )
{
    set-alias sublime $sublime_path
    set-alias vi sublime
    set-alias notepad sublime
}
else {
    write-warning "Can't find sublime."
}


$env:PATH += ";" + $profile_dir + "\"

if (Test-Path $github_path)
{
    $env:PATH += ";" + $github_path
}

import-module csb-util

echo "Installed csb-util: "
get-command -module csb-util

# Make CD work like Unix
function ChangeDirectory ($Path) {
    if($Path -eq "-") {
        Pop-Location
    }
    elseif ($Path) {
        Push-Location $Path
    }
    else { 
        Push-Location
    }
}

try{ $PSDefaultParameterValues.Add("Push-Location:Path", $env:HOME) } catch{}
Remove-Item alias:cd
set-alias cd ChangeDirectory -Option AllScope