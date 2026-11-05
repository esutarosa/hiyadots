use std "path add"

$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join "scripts")
    ($nu.data-dir | path join "completions")
]

$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join "plugins")
]

$env.EDITOR = "nvim"
let fzf_theme = ($env.HOME | path join ".config/fzf/hiyashinsu-moondust")
if ($fzf_theme | path exists) { $env.FZF_DEFAULT_OPTS_FILE = $fzf_theme }
$env.BUN_INSTALL = ($env.HOME | path join ".bun")
$env.GOPATH = ($env.HOME | path join "go")
$env.GOBIN = ($env.GOPATH | path join "bin")
$env.STARSHIP_CONFIG = ($env.HOME | path join ".config/starship/starship.toml")
$env.CARAPACE_BRIDGES = "zsh,fish,bash,inshellisense"
$env.DIRENV_LOG_FORMAT = ""

path add "/opt/homebrew/bin"
path add "/opt/homebrew/sbin"
path add "/usr/local/bin"
path add ($env.HOME | path join ".docker/bin")
path add "/Applications/Docker.app/Contents/Resources/bin"
path add ($env.HOME | path join ".turso")
path add ($env.HOME | path join ".local/bin")
path add ($env.HOME | path join ".bun/bin")
path add $env.GOBIN
path add ($env.HOME | path join ".cargo/bin")

let nvm_default = ($env.HOME | path join ".nvm/alias/default")
if ($nvm_default | path exists) {
    path add ($env.HOME | path join $".nvm/versions/node/v(open --raw $nvm_default | str trim)/bin")
}

let init_dir = ($env.HOME | path join ".cache/nushell-init")
mkdir $init_dir
for tool in [[name command]; [zoxide { zoxide init nushell }] [starship { starship init nu }]] {
    let file = ($init_dir | path join $"($tool.name).nu")
    if (which $tool.name | is-not-empty) { do $tool.command | save -f $file } else { "" | save -f $file }
}

def --env cx [arg] {
    cd $arg
    ls -l
}

def ff [] {
    aerospace list-windows --all | fzf --bind 'enter:execute(bash -c "aerospace focus --window-id {1}")+abort'
}

alias c = clear
alias n = nvim
alias t = tmux

alias l = ^eza -lh --icons=auto
alias ll = ^eza -lha --icons=auto --sort=name --group-directories-first
alias ld = ^eza -lhD --icons=auto
alias lt = ^eza --icons=auto --tree

def nls [path: path = "."] { ls $path | table -e }

alias .. = cd ..
alias ... = cd ../..
alias d3 = cd ../../..
alias d4 = cd ../../../..
alias d5 = cd ../../../../..

alias un = brew uninstall
def up [] { brew update; brew upgrade }
alias pl = brew list
alias pa = brew search
alias pc = brew cleanup
alias po = brew outdated

alias mkdir = ^mkdir -p

alias gc = git commit -m
alias gca = git commit -a -m
alias gp = git push origin HEAD
alias gpu = git pull origin
alias gst = git status
alias glog = git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit
alias gdiff = git diff
alias gco = git checkout
alias gb = git branch
alias gba = git branch -a
alias gadd = git add
alias ga = git add -p
alias gcoall = git checkout -- .
alias gr = git remote
alias gre = git reset

alias k = kubectl
alias ka = kubectl apply -f
alias kg = kubectl get
alias kd = kubectl describe
alias kdel = kubectl delete
alias kl = kubectl logs -f
alias kgpo = kubectl get pod
alias kgd = kubectl get deployments
alias kc = kubectx
alias kns = kubens
alias ke = kubectl exec -it
