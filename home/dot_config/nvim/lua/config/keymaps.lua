local km = require("util.keymaps")
local nmap = km.n
local vmap = km.v
local actions = km.actions

nmap("x", '"_x', "Delete char (no yank)")

nmap("<Leader>p", '"0p', "Paste from yank (0)")
nmap("<Leader>P", '"0P', "Paste before from yank (0)")
vmap("<Leader>p", '"0p', "Paste (visual) from yank (0)")
nmap("<Leader>c", '"_c', "Change (no yank)")
nmap("<Leader>C", '"_C', "Change to EOL (no yank)")
vmap("<Leader>c", '"_c', "Change (visual, no yank)")
vmap("<Leader>C", '"_C', "Change (visual, no yank)")
nmap("<Leader>d", '"_d', "Delete (no yank)")
nmap("<Leader>D", '"_D', "Delete to EOL (no yank)")
vmap("<Leader>d", '"_d', "Delete (visual, no yank)")
vmap("<Leader>D", '"_D', "Delete (visual, no yank)")

nmap("+", "<C-a>", "Increment number")
nmap("-", "<C-x>", "Decrement number")

nmap("<Leader>a", "gg<S-v>G", "Select all")

nmap("<Leader>w", ":update<CR>", "Write if changed")
nmap("<Leader>q", ":quit<CR>", "Quit")
nmap("<Leader>Q", ":qa<CR>", "Quit all")

nmap("<Leader>t", actions.neo_tree_toggle, "Neo-tree toggle")

nmap("<Leader>f", actions.neo_tree_reveal, "Neo-tree reveal")

nmap("te", actions.tabedit_current_dir, "Tab edit in current dir", { silent = false })
nmap("<Tab>", ":tabnext<CR>", "Next tab")
nmap("<S-Tab>", ":tabprev<CR>", "Prev tab")
nmap("tw", ":tabclose<CR>", "Close tab")

nmap("ss", ":split<CR>", "Split horizontal")
nmap("sv", ":vsplit<CR>", "Split vertical")

nmap("sh", "<C-w>h", "Focus left")
nmap("sk", "<C-w>k", "Focus up")
nmap("sj", "<C-w>j", "Focus down")
nmap("sl", "<C-w>l", "Focus right")

nmap("<C-h>", actions.resize_left, "Resize ←")
nmap("<C-l>", actions.resize_right, "Resize →")
nmap("<C-k>", actions.resize_up, "Resize ↑")
nmap("<C-j>", actions.resize_down, "Resize ↓")

nmap("<D-j>", ":m .+1<CR>==", "Move line down")
nmap("<D-k>", ":m .-2<CR>==", "Move line up")
vmap("<D-j>", ":m '>+1<CR>gv=gv", "Move selection down")
vmap("<D-k>", ":m '<-2<CR>gv=gv", "Move selection up")

nmap("<leader>rn", actions.rename_word_in_buffer, "Replace word in buffer")

nmap("<leader>O", actions.open_current_dir, "Open current dir in file manager")
