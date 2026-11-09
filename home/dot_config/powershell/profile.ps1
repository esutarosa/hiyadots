[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

function Test-Tool($name) { [bool](Get-Command $name -CommandType Application -ErrorAction SilentlyContinue) }

$config = Join-Path $HOME ".config"
$fzfTheme = Join-Path $config "fzf\hiyashinsu-moondust"
if (Test-Path $fzfTheme) { $env:FZF_DEFAULT_OPTS_FILE = $fzfTheme }
$env:STARSHIP_CONFIG = Join-Path $config "starship\starship.toml"

# Built-in aliases take priority over functions with the same name.
foreach ($name in "ls", "gc", "gp", "gl", "gm", "gi", "gu") {
  Remove-Item "Alias:\$name" -Force -ErrorAction SilentlyContinue
}

function c { Clear-Host }
function n { nvim @args }

if (Test-Tool eza) {
  function l { eza -lh --icons=auto @args }
  function ls { eza -1 --icons=auto @args }
  function ll { eza -lha --icons=auto --sort=name --group-directories-first @args }
  function ld { eza -lhD --icons=auto @args }
  function lt { eza --icons=auto --tree @args }
}

if (Test-Tool winget) {
  function un { winget uninstall @args }
  function up { winget upgrade --all @args }
  function pl { winget list @args }
  function pa { winget search @args }
  function po { winget upgrade @args }
}

function .. { Set-Location .. }
function ... { Set-Location ..\.. }
function d3 { Set-Location ..\..\.. }
function d4 { Set-Location ..\..\..\.. }
function d5 { Set-Location ..\..\..\..\.. }

function gc { git commit -m @args }
function gca { git commit -a -m @args }
function gp { git push origin HEAD @args }
function gpu { git pull origin @args }
function gst { git status @args }
function glog { git log --graph --topo-order "--pretty=%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N" --abbrev-commit @args }
function gdiff { git diff @args }
function gco { git checkout @args }
function gb { git branch @args }
function gba { git branch -a @args }
function gadd { git add @args }
function ga { git add -p @args }
function gcoall { git checkout -- . }
function gr { git remote @args }
function gre { git reset @args }

function k { kubectl @args }
function ka { kubectl apply -f @args }
function kg { kubectl get @args }
function kd { kubectl describe @args }
function kdel { kubectl delete @args }
function kl { kubectl logs -f @args }
function kgpo { kubectl get pod @args }
function kgd { kubectl get deployments @args }
function kc { kubectx @args }
function kns { kubens @args }
function ke { kubectl exec -it @args }

if (Get-Module -ListAvailable PSReadLine) {
  Set-PSReadLineOption -EditMode Emacs
  Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
  Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
  if ((Get-Command Set-PSReadLineOption).Parameters.ContainsKey("PredictionSource")) {
    Set-PSReadLineOption -PredictionSource History
  }
}

if (Test-Tool zoxide) {
  Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })
  function zi {
    $target = zoxide query -l | fzf
    if ($target) { Set-Location $target }
  }
  function zf { zi }
}

if (Test-Tool starship) {
  Invoke-Expression (& starship init powershell)
}
