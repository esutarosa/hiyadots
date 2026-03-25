# env.nu
#
# Installed by:
# version = "0.111.0"

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
path add ($env.HOME | path join ".local/share/mise/shims")
path add ($env.HOME | path join ".local/bin")
path add ($env.HOME | path join ".bun/bin")
path add $env.GOBIN
path add ($env.HOME | path join ".cargo/bin")

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

alias l = ls --all
alias ll = ls -l
alias lt = eza --tree --level=2 --long --icons --git

alias .. = cd ..
alias ... = cd ../..
alias d3 = cd ../../..
alias d4 = cd ../../../..
alias d5 = cd ../../../../..

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
