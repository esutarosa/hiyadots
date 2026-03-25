local km = require("util.keymaps")
local nmap = km.n
local vmap = km.v
local actions = km.actions

-- Delete char w/o yanking
nmap("x", '"_x', "Delete char (no yank)")

-- Do things without affecting the registers
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

-- Increment/decrement
nmap("+", "<C-a>", "Increment number")
nmap("-", "<C-x>", "Decrement number")

-- Select all
nmap("<Leader>a", "gg<S-v>G", "Select all")

-- Save / quit
nmap("<Leader>w", ":update<CR>", "Write if changed")
nmap("<Leader>q", ":quit<CR>", "Quit")
nmap("<Leader>Q", ":qa<CR>", "Quit all")

-- Toggle tree on <leader>t
nmap("<Leader>t", actions.neo_tree_toggle, "Neo-tree toggle")

-- Reveal current file
nmap("<Leader>f", actions.neo_tree_reveal, "Neo-tree reveal")

-- Tabs
nmap("te", actions.tabedit_current_dir, "Tab edit in current dir", { silent = false })
nmap("<Tab>", ":tabnext<CR>", "Next tab")
nmap("<S-Tab>", ":tabprev<CR>", "Prev tab")
nmap("tw", ":tabclose<CR>", "Close tab")

-- Splits
nmap("ss", ":split<CR>", "Split horizontal")
nmap("sv", ":vsplit<CR>", "Split vertical")

-- Move between windows
nmap("sh", "<C-w>h", "Focus left")
nmap("sk", "<C-w>k", "Focus up")
nmap("sj", "<C-w>j", "Focus down")
nmap("sl", "<C-w>l", "Focus right")

-- Resize windows
nmap("<C-h>", actions.resize_left, "Resize ←")
nmap("<C-l>", actions.resize_right, "Resize →")
nmap("<C-k>", actions.resize_up, "Resize ↑")
nmap("<C-j>", actions.resize_down, "Resize ↓")
nmap("<C-Left>", actions.resize_left, "Resize ←")
nmap("<C-Right>", actions.resize_right, "Resize →")
nmap("<C-Up>", actions.resize_up, "Resize ↑")
nmap("<C-Down>", actions.resize_down, "Resize ↓")
nmap("<C-S-h>", actions.resize_left, "Resize ←")
nmap("<C-S-l>", actions.resize_right, "Resize →")
nmap("<C-S-k>", actions.resize_up, "Resize ↑")
nmap("<C-S-j>", actions.resize_down, "Resize ↓")
nmap("<leader>wh", actions.resize_left, "Resize left")
nmap("<leader>wl", actions.resize_right, "Resize right")
nmap("<leader>wk", actions.resize_up, "Resize up")
nmap("<leader>wj", actions.resize_down, "Resize down")

-- Move lines up/down with Command+J / Command+K and Alt+J / Alt+K
nmap("<D-j>", ":m .+1<CR>==", "Move line down")
nmap("<D-k>", ":m .-2<CR>==", "Move line up")
vmap("<D-j>", ":m '>+1<CR>gv=gv", "Move selection down")
vmap("<D-k>", ":m '<-2<CR>gv=gv", "Move selection up")

-- Diagnostics
nmap("]d", actions.diagnostic_next, "Next diagnostic")

-- Replace
nmap("<leader>rn", actions.rename_word_in_buffer, "Replace word in buffer")

nmap("<leader>O", actions.open_current_dir, "Open current dir in file manager")
