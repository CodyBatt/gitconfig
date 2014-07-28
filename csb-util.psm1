

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

set-alias git-clean Clear-OldGitBranches 
set-alias git-undo  Undo-LastGitCommit

Export-ModuleMember -Function Clear-OldGitBranches, Undo-LastGitCommit, mklink, Reset-Nuget -Alias git-clean, git-undo
