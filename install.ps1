# Usage: powershell -ExecutionPolicy Bypass -File install.ps1 [windows|pick]. Other arguments go to chezmoi init.
param([string]$Name = "windows")
$ErrorActionPreference = "Stop"

function Update-Path {
  $env:Path = [Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [Environment]::GetEnvironmentVariable("Path", "User")
}

# PowerShell refuses to load the profile under the default client policy.
if ((Get-ExecutionPolicy -Scope CurrentUser) -in "Undefined", "Restricted") {
  try {
    Set-ExecutionPolicy -Scope CurrentUser RemoteSigned -Force
  } catch {
    Write-Warning "Could not allow local scripts, the PowerShell profile may not load."
  }
}

# Neovim reads its config from here instead of AppData.
$config = Join-Path $HOME ".config"
[Environment]::SetEnvironmentVariable("XDG_CONFIG_HOME", $config, "User")
$env:XDG_CONFIG_HOME = $config
$env:DOTS_PROFILE = $Name

if (-not (Get-Command chezmoi -ErrorAction SilentlyContinue)) {
  winget install --id twpayne.chezmoi --exact --silent --accept-package-agreements --accept-source-agreements
  Update-Path
}

chezmoi init --apply --force --source $PSScriptRoot @args
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

$documents = [Environment]::GetFolderPath("MyDocuments")
$line = '. "$HOME\.config\powershell\profile.ps1"'
foreach ($folder in "WindowsPowerShell", "PowerShell") {
  $file = Join-Path $documents "$folder\Microsoft.PowerShell_profile.ps1"
  New-Item -ItemType Directory -Force (Split-Path $file) | Out-Null
  if (-not ((Test-Path $file) -and (Select-String -Quiet -SimpleMatch -Pattern $line -Path $file))) {
    Add-Content -Path $file -Value $line
  }
}
