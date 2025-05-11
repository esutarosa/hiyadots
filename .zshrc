alias c='clear'
alias n='nvim'
alias t='tmux' 
alias l='eza -lh --icons=auto'
alias ls='eza -1 --icons=auto'
alias ll='eza -lha --icons=auto --sort=name --group-directories-first'
alias ld='eza -lhD --icons=auto'
alias lt='eza --icons=auto --tree'

# Arch Linux
# alias un='$aurhelper -Rns'
# alias up='$aurhelper -Syu'
# alias pl='$aurhelper -Qs'
# alias pa='$aurhelper -Ss'
# alias pc='$aurhelper -Sc'
# alias po='$aurhelper -Qtdq | $aurhelper -Rns -'

# MacOS
# alias un='brew uninstall'
# alias up='brew update && brew upgrade'
# alias pl='brew list'
# alias pa='brew search'
# alias pc='brew cleanup'
# alias po='brew outdated'

alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

eval "$(zoxide init zsh)"

alias mkdir='mkdir -p'

# History
HISTFILE=$HOME/.history
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
