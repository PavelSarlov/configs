Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

#region utils
nal -Name sudo -Value "runas /user:domain\administrator"
nal -Name grep -Value "sls"

function dirname([string]$FilePath) {
    Split-Path -Path "$FilePath" -Resolve
}
function basename([string]$FilePath) {
    Split-Path -Path "$FilePath" -Leaf
}

function touch([string]$FilePath) {
    if(Test-Path "$FilePath") {
        (Get-ChildItem "$FilePath").LastWriteTime = Get-Date
    }
    else {
        New-Item -ItemType file -Path "$FilePath"
    }
}

function test([string]$FilePath, [string]$FileType = "") {
    [string]$Type = "Any"
    switch($FileType) {
        "d" {$Type = "Container"}
        "f" {$Type = "Leaf"}
        default {}
    }
    Test-Path -Path $FilePath -PathType $Type 
}
#endregion

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

#region conda initialize
# !! Contents within this block are managed by 'conda init' !!
(& "C:\Users\muchd\anaconda3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | Invoke-Expression
#endregion
