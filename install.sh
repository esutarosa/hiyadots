#!/bin/sh
# Usage: install.sh [default|server|pick]. No argument asks for the profile. Other arguments go to chezmoi init.
set -eu

repo=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
if [ $# -gt 0 ]; then
  DOTS_PROFILE=$1
  export DOTS_PROFILE
  shift
fi
sudo=""
[ "$(id -u)" -eq 0 ] || sudo=sudo

PATH="$HOME/.local/bin:$PATH"
if ! command -v chezmoi >/dev/null; then
  command -v curl >/dev/null || { $sudo apt-get update && $sudo apt-get install -y curl; }
  sh -c "$(curl -fsLS https://get.chezmoi.io)" -- -b "$HOME/.local/bin"
fi

[ "${DOTS_PROFILE:-}" != server ] || set -- --force "$@"
chezmoi init --apply --source "$repo" "$@"

zsh_path=$(command -v zsh || true)
login_shell=${SHELL:-}
if [ "$(uname)" != Darwin ] && [ -n "$zsh_path" ] && [ "${login_shell##*/}" != zsh ]; then
  $sudo chsh -s "$zsh_path" "$(id -un)" || echo "Set the login shell yourself: chsh -s $zsh_path" >&2
fi
