$branches = git branch --merged | ?{$_ -notmatch "\* master"} | ?{$_ -notmatch "master"} | ?{$_ -notmatch "\* *"} | %{$_.Trim() }
 
if (-not $branches) {
    echo "No merged branches detected"
    exit 0
}
 
echo "Merged branches to remove..."
echo $branches
 
$branches | %{ git branch -d "$_" }