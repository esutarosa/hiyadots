local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- safer: define a helper to set with desc
local function nmap(lhs, rhs, desc)
	keymap.set("n", lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
end

local function vmap(lhs, rhs, desc)
	keymap.set("v", lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
end

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
nmap("<Leader>t", function()
	require("neo-tree.command").execute({ toggle = true, position = "left", source = "filesystem" })
end, "Neo-tree toggle")

-- Reveal current file
nmap("<Leader>f", function()
	require("neo-tree.command").execute({ action = "focus", reveal = true, position = "left", source = "filesystem" })
end, "Neo-tree reveal")

-- Tabs
keymap.set("n", "te", ":tabedit ", { noremap = true, silent = false, desc = "Tab edit" })
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
nmap("<C-S-h>", "<C-w><", "Resize ←")
nmap("<C-S-l>", "<C-w>>", "Resize →")
nmap("<C-S-k>", "<C-w>+", "Resize ↑")
nmap("<C-S-j>", "<C-w>-", "Resize ↓")

-- Move lines up/down with Command+J / Command+K (mac)
nmap("<D-Down>", ":m .+1<CR>==", "Move line down")
nmap("<D-Up>", ":m .-2<CR>==", "Move line up")
vmap("<D-Down>", ":m '>+1<CR>gv=gv", "Move selection down")
vmap("<D-Up>", ":m '<-2<CR>gv=gv", "Move selection up")

-- Diagnostics jump helper
local function diag_jump(dir, severity)
	vim.diagnostic.jump({
		count = (dir == "next" and vim.v.count1 or -vim.v.count1),
		float = true,
		severity = severity,
	})
end

-- Diagnostics
nmap("<C-j>", function()
	diag_jump("next")
end, "Next diagnostic")

-- Rename all similarities (project-wide simple replace)
nmap("<leader>rn", function()
	local current_word = vim.fn.expand("<cword>")
	local new_word = vim.fn.input("Rename all '" .. current_word .. "' to: ")
	if new_word ~= nil and #new_word > 0 then
		vim.cmd("%s/\\<" .. current_word .. "\\>/" .. new_word .. "/g")
	end
end, "Rename word (global)")

keymap.set("n", "<leader>O", function()
	local path = vim.fn.expand("%:p:h")
	if vim.fn.has("mac") == 1 then
		vim.fn.jobstart({ "open", path }, { detach = true })
	elseif vim.fn.has("win32") == 1 then
		vim.fn.jobstart({ "explorer", path }, { detach = true })
	else
		vim.fn.jobstart({ "xdg-open", path }, { detach = true })
	end
end, { desc = "Open current dir in file manager" })
