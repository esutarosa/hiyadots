#!/bin/sh
# Run from the repo root: sh tests/remove-unselected.sh. Uses fake brew and pacman in a throwaway $HOME.
set -eu

repo=$(pwd)
tmpl="$repo/home/.chezmoiscripts/run_onchange_after_remove-unselected.sh.tmpl"
work=$(mktemp -d "${TMPDIR:-/tmp}/dots-test.XXXXXX")
trap 'rm -rf "$work"' EXIT
real_path=$PATH
fails=0

check() {
  desc=$1; shift
  if "$@"; then echo "ok   $desc"; else echo "FAIL $desc"; fails=$((fails + 1)); fi
}
absent() { [ ! -e "$1" ] && [ ! -L "$1" ]; }

fake() {
  printf '#!/bin/sh\n%s\n' "$3" > "$1/$2"
  chmod +x "$1/$2"
}

run() {
  os=$1
  home="$work/$os/home"; state="$work/$os/state"; shims="$work/$os/shims"
  mkdir -p "$home" "$state" "$shims"
  cz() {
    HOME="$home" PATH="$real_path" chezmoi --source "$repo" --config "$state/chezmoi.toml" \
      --persistent-state "$state/state.boltdb" --cache "$state/cache" --destination "$home" --no-tty "$@"
  }
  cz init --promptDefaults \
    --promptMultichoice 'shell=zsh/nushell' --promptMultichoice 'terminal=ghostty/alacritty/tmux' \
    --promptMultichoice 'desktop=kanata' --promptMultichoice 'cli=zoxide'
  cz apply --exclude=scripts
  mkdir -p "$home/.config/alacritty/themes/alacritty-theme"
  echo mine > "$home/.config/alacritty/themes/alacritty-theme/own-file"

  fake "$shims" uname "echo $os"
  fake "$shims" sudo 'exec "$@"'
  if [ "$os" = Darwin ]; then
    fake "$shims" brew "if [ \"\$1\" = list ]; then exit 0; fi; echo \"brew \$*\" >> '$home/calls'"
  else
    fake "$shims" pacman "if [ \"\$1\" = -Qq ]; then exit 0; fi; echo \"pacman \$*\" >> '$home/calls'"
  fi
  : > "$home/calls"
  remove() {
    cz --override-data '{"tools":{"shared":{"group":"cli","brew":["zoxide"],"pacman":["zoxide"]}}}' \
      execute-template < "$tmpl" > "$state/remove.sh"
    HOME="$home" PATH="$shims:/usr/bin:/bin" DOTS_REMOVE=yes sh "$state/remove.sh" > "$state/out" 2>&1
  }

  remove
  cp "$home/calls" "$home/first-calls"

  echo shared >> "$home/.local/state/dots/selected"
  cz init --prompt --promptDefaults \
    --promptMultichoice 'shell=zsh' --promptMultichoice 'terminal=ghostty/tmux' \
    --promptMultichoice 'desktop=kanata' --promptMultichoice 'cli=zoxide'
  remove
}

run Darwin
home="$work/Darwin/home"
check "macOS: unselected formula removed" grep -q 'brew uninstall --formula nushell' "$home/calls"
check "macOS: first run removes nothing" test ! -s "$home/first-calls"
check "macOS: keep_package cask stays" sh -c "! grep -q alacritty '$home/calls'"
check "macOS: never selected tool not flagged" sh -c "! grep -q mise '$home/calls'"
check "macOS: selected package stays" sh -c "! grep -qE 'uninstall .* (tmux|ghostty)$' '$home/calls'"
check "macOS: package shared with a selected tool stays" sh -c "! grep -q zoxide '$home/calls'"
check "macOS: nushell link in ~/Library removed" absent "$home/Library/Application Support/nushell/env.nu"
check "macOS: unselected config link removed" absent "$home/.config/nushell/env.nu"
check "macOS: selected config link stays" test -L "$home/.config/tmux/tmux.conf"
check "macOS: keep_package config link still removed" absent "$home/.config/alacritty/alacritty.toml"
check "macOS: own file in unselected dir stays" test -f "$home/.config/alacritty/themes/alacritty-theme/own-file"
check "macOS: selection saved" sh -c "! grep -q nushell '$home/.local/state/dots/selected'"

run Linux
home="$work/Linux/home"
check "Linux: unselected package removed" grep -q 'pacman -Rns --noconfirm nushell' "$home/calls"
check "Linux: selected package stays" sh -c "! grep -q ' tmux$' '$home/calls'"
check "Linux: package shared with a selected tool stays" sh -c "! grep -q zoxide '$home/calls'"
check "Linux: no brew called" sh -c "! grep -q brew '$home/calls'"
check "Linux: unselected config link removed" absent "$home/.config/nushell/env.nu"

none="$work/none"
mkdir -p "$none/home"
if HOME="$none/home" chezmoi --source "$repo" --config "$none/chezmoi.toml" --persistent-state "$none/state.boltdb" \
  --cache "$none/cache" --destination "$none/home" --no-tty init --promptDefaults > "$none/out" 2>&1; then
  echo "FAIL init with nothing selected must fail"; fails=$((fails + 1))
else
  check "init with nothing selected fails" grep -q 'Select at least one tool' "$none/out"
fi

echo "failed: $fails"
[ "$fails" = 0 ]
