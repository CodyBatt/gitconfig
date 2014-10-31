

function Clear-OldGitBranches {
    $cmd = (join-path "$profile_dir" "git-cleanup.ps1")
    $expression = "'$cmd'"
    Invoke-Expression  "& $expression"
}

function mklink {     
	cmd /c mklink $args 
}

function Reset-Nuget ($file) {
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

function Undo-LastGitCommit {
    git reset --soft HEAD~1
    git reset -q HEAD
    echo "Reverted and unstaged last commit."
}

function Switch-GitKey($key) {
	Stop-SshAgent
	Start-SshAgent
	Add-SshKey (join-path $env:USERPROFILE ".ssh\$key")
	Add-SshKey -l	
	$result = & "ssh" -T git@github.com 2>&1
	$result -replace "Hi (.*)!.*", "Switched to: `$1"
}

function Show-GitKey {
	dir (join-path $env:USERPROFILE ".ssh\*_rsa") | %{$_.Name}
}

set-alias git-clean Clear-OldGitBranches 
set-alias git-undo  Undo-LastGitCommit

Export-ModuleMember -Function Switch-GitKey, Show-GitKey, Clear-OldGitBranches, Undo-LastGitCommit, mklink, Reset-Nuget -Alias git-clean, git-undo
