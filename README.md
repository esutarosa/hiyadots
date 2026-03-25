# Dotfiles

## Keybindings

### LazyVim

`Leader` = `Space`

#### Core

| Key                   | Action                                 |
| --------------------- | -------------------------------------- |
| `x`                   | Delete char without yank               |
| `Space+p` / `Space+P` | Paste from yank register               |
| `Space+c` / `Space+C` | Change without yank                    |
| `Space+d` / `Space+D` | Delete without yank                    |
| `+` / `-`             | Increment / decrement number           |
| `Space+a`             | Select all                             |
| `Space+w`             | Save file                              |
| `Space+q`             | Quit window                            |
| `Space+Q`             | Quit all                               |
| `Space+rn`            | Replace word in current buffer         |
| `Space+O`             | Open current directory in file manager |

#### Files and Search

| Key                 | Action                                   |
| ------------------- | ---------------------------------------- |
| `Space+t`           | Toggle Neo-tree                          |
| `Space+f`           | Reveal current file in Neo-tree          |
| `te`                | New tab in current directory             |
| `Tab` / `Shift+Tab` | Next / previous tab                      |
| `tw`                | Close tab                                |
| `;f`                | Find files                               |
| `;g`                | Live grep                                |
| `\\`                | Buffers                                  |
| `;;`                | Resume telescope                         |
| `;e`                | Diagnostics list                         |
| `;s`                | Symbols                                  |
| `sf`                | File browser in current buffer directory |
| `;r`                | Find and replace                         |
| `;d`                | Database UI                              |

#### Splits and Windows

| Key                                 | Action                          |
| ----------------------------------- | ------------------------------- |
| `ss` / `sv`                         | Horizontal / vertical split     |
| `sh` `sj` `sk` `sl`                 | Focus left / down / up / right  |
| `Ctrl+h` `Ctrl+j` `Ctrl+k` `Ctrl+l` | Resize left / down / up / right |

#### Editing

| Key                 | Action                                |
| ------------------- | ------------------------------------- |
| `Cmd+j` / `Cmd+k`   | Move line down / up                   |
| `Space+/`           | Flash jump                            |
| `Space+?`           | Flash Treesitter                      |
| `Ctrl+n` / `Ctrl+p` | Add next / previous multicursor match |
| `Space+mi`          | Toggle multicursor                    |

#### LSP

| Key        | Action                          |
| ---------- | ------------------------------- |
| `gd`       | Go to definition with Telescope |
| `Space+cr` | Rename symbol                   |
| `K`        | Hover                           |
| `]d`       | Next diagnostic                 |

#### LazyVim Toggles

| Key        | Action                                |
| ---------- | ------------------------------------- |
| `Space+uf` | Toggle auto format                    |
| `Space+uF` | Toggle auto format for current buffer |

### Tmux

`Prefix` = `Ctrl+t`

| Key                | Action                           |
| ------------------ | -------------------------------- |
| `Prefix+r`         | Reload tmux config               |
| `Prefix+o`         | Open current pane path in Finder |
| `Prefix+e`         | Kill all other panes             |
| `Prefix+g`         | Open LazyGit popup               |
| `Prefix+O`         | Open tmux-sessionx               |
| `Ctrl+Shift+Left`  | Move window left                 |
| `Ctrl+Shift+Right` | Move window right                |

### Yabai

These bindings are defined in `skhd` and control `yabai`.

| Key                             | Action                                   |
| ------------------------------- | ---------------------------------------- |
| `Alt+h` `Alt+j` `Alt+k` `Alt+l` | Focus west / south / north / east window |
| `Alt+s` / `Alt+g`               | Focus left / right display               |
| `Shift+Alt+h` `j` `k` `l`       | Swap window west / south / north / east  |
| `Ctrl+Alt+h` `j` `k` `l`        | Warp window west / south / north / east  |
| `Shift+Alt+r`                   | Rotate layout                            |
| `Shift+Alt+y` / `Shift+Alt+x`   | Mirror Y / X axis                        |
| `Shift+Alt+t`                   | Toggle float                             |
| `Shift+Alt+m`                   | Toggle zoom fullscreen                   |
| `Shift+Alt+e`                   | Balance windows                          |
| `Shift+Alt+s` / `Shift+Alt+g`   | Move window to left / right display      |
| `Shift+Alt+p` / `Shift+Alt+n`   | Move window to previous / next space     |
| `Shift+Alt+1..9`                | Move window to space 1..9                |
| `Ctrl+Alt+q` / `Ctrl+Alt+s`     | Stop / start yabai service               |
