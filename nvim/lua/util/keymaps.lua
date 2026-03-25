local M = {}

-- Base opts for all mappings
M.opts = { noremap = true, silent = true }

local function merged_opts(desc, extra)
	return vim.tbl_extend("force", M.opts, extra or {}, desc and { desc = desc } or {})
end

-- Generic mapping helper
function M.map(mode, lhs, rhs, desc, extra)
	vim.keymap.set(mode, lhs, rhs, merged_opts(desc, extra))
end

-- Short helper for normal mode
function M.n(lhs, rhs, desc, extra)
	M.map("n", lhs, rhs, desc, extra)
end

-- Short helper for visual mode
function M.v(lhs, rhs, desc, extra)
	M.map("v", lhs, rhs, desc, extra)
end

-- Current file dir or cwd for unnamed buffers
local function current_dir()
	local buf_dir = vim.fn.expand("%:p:h")
	if buf_dir == nil or buf_dir == "" or buf_dir == "." then
		return vim.fn.getcwd()
	end
	return buf_dir
end

-- Actions used by keymaps.lua
M.actions = {}

local function neo_tree_command()
	local ok, command = pcall(require, "neo-tree.command")
	if ok then
		return command
	end

	pcall(require("lazy").load, { plugins = { "neo-tree.nvim" } })
	return require("neo-tree.command")
end

-- Toggle neo-tree
function M.actions.neo_tree_toggle()
	neo_tree_command().execute({ toggle = true, position = "left", source = "filesystem" })
end

-- Reveal the current file in neo-tree
function M.actions.neo_tree_reveal()
	neo_tree_command().execute({ action = "focus", reveal = true, position = "left", source = "filesystem" })
end

-- Start creating a file in the current buffer dir
function M.actions.tabedit_current_dir()
	local target = vim.fn.fnameescape(current_dir()) .. "/"
	local keys = vim.api.nvim_replace_termcodes(":tabedit " .. target, true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end

-- Jump to the next diagnostic
function M.actions.diagnostic_next()
	vim.diagnostic.jump({
		count = vim.v.count1,
		float = true,
	})
end

-- Replace all matches in the current buffer
function M.actions.rename_word_in_buffer()
	local current_word = vim.fn.expand("<cword>")
	local search = vim.fn.escape(current_word, "\\/")
	local new_word = vim.fn.input("Replace all '" .. current_word .. "' with: ")
	if new_word ~= nil and #new_word > 0 then
		local replacement = vim.fn.escape(new_word, "\\/&")
		vim.cmd("%s/\\<" .. search .. "\\>/" .. replacement .. "/g")
	end
end

-- Open the current file dir in the system file manager
function M.actions.open_current_dir()
	local path = current_dir()
	if vim.fn.has("mac") == 1 then
		vim.fn.jobstart({ "open", path }, { detach = true })
	elseif vim.fn.has("win32") == 1 then
		vim.fn.jobstart({ "explorer", path }, { detach = true })
	else
		vim.fn.jobstart({ "xdg-open", path }, { detach = true })
	end
end

local function has_neighbor(direction)
	return vim.fn.winnr(direction) ~= vim.fn.winnr()
end

local function resize_notice(message)
	vim.notify(message, vim.log.levels.INFO, { title = "Resize" })
end

local function neighbor_win(direction)
	local winnr = vim.fn.winnr(direction)
	if winnr == vim.fn.winnr() then
		return nil
	end
	return vim.fn.win_getid(winnr)
end

local function resize_in_window(win, command)
	local current = vim.api.nvim_get_current_win()
	if win == nil or win == current then
		vim.cmd(command)
		return
	end
	vim.api.nvim_win_call(win, function()
		vim.cmd(command)
	end)
end

local function resize_width_towards(direction)
	local left = neighbor_win("h")
	local right = neighbor_win("l")

	if direction == "left" then
		if left then
			resize_in_window(left, "vertical resize -1")
			return
		end
		if right then
			resize_in_window(nil, "vertical resize -1")
			return
		end
	else
		if right then
			resize_in_window(nil, "vertical resize +1")
			return
		end
		if left then
			resize_in_window(left, "vertical resize +1")
			return
		end
	end

	resize_notice("No side split to resize against")
end

local function resize_height_towards(direction)
	local up = neighbor_win("k")
	local down = neighbor_win("j")

	if direction == "up" then
		if up and down then
			resize_in_window(down, "resize +1")
			return
		end
		if up then
			resize_in_window(up, "resize -1")
			return
		end
		if down then
			resize_in_window(nil, "resize -1")
			return
		end
	else
		if up and down then
			resize_in_window(up, "resize +1")
			return
		end
		if down then
			resize_in_window(nil, "resize +1")
			return
		end
		if up then
			resize_in_window(up, "resize +1")
			return
		end
	end

	resize_notice("No split above or below to resize against")
end

-- Resize current window in a predictable way
function M.actions.resize_left()
	resize_width_towards("left")
end

function M.actions.resize_right()
	resize_width_towards("right")
end

function M.actions.resize_up()
	resize_height_towards("up")
end

function M.actions.resize_down()
	resize_height_towards("down")
end

return M
