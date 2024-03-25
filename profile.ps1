Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Import-Module posh-git
Import-Module NuGet
Set-Alias more "$(where.exe less)"

function prompt
{
  $loc = Get-Location

  $prompt = & $GitPromptScriptBlock

  $prompt += "$([char]27)]9;12$([char]7)"
  if ($loc.Provider.Name -eq "FileSystem")
  {
    $prompt += "$([char]27)]9;9;`"$($loc.ProviderPath)`"$([char]27)\"
  }

  $prompt
}

if (([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
# set user home dir
}
