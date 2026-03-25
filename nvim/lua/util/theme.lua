local M = {}

M.default = "paramount"
M.state_file = vim.fn.stdpath("state") .. "/colorscheme.txt"

local function load_plugin(name)
	local ok, lazy = pcall(require, "lazy")
	if ok then
		lazy.load({ plugins = { name } })
	end
end

local function apply_transparency()
	local hl = vim.api.nvim_set_hl
	hl(0, "Normal", { bg = "none" })
	hl(0, "NormalNC", { bg = "none" })
	hl(0, "SnacksDashboardNormal", { bg = "none" })
	hl(0, "SignColumn", { bg = "none" })
	hl(0, "StatusColumn", { bg = "none" })
	hl(0, "LineNr", { bg = "none" })
	hl(0, "CursorLineNr", { bg = "none" })
	hl(0, "FoldColumn", { bg = "none" })
	hl(0, "CursorLineSign", { bg = "none" })
	hl(0, "CursorLineFold", { bg = "none" })
	hl(0, "CursorLine", { bg = "none" })
	hl(0, "EndOfBuffer", { bg = "none" })
	hl(0, "NeoTreeNormal", { bg = "none" })
	hl(0, "NeoTreeNormalNC", { bg = "none" })
	hl(0, "NeoTreeWinSeparator", { bg = "none" })
end

M.themes = {
	paramount = {
		label = "paramount",
		apply = function()
			vim.cmd.colorscheme("paramount")
		end,
	},
	["neomodern-moon"] = {
		label = "neomodern-moon",
		apply = function()
			load_plugin("neomodern.nvim")
			require("neomodern").setup({
				theme = "moon",
				background = "default",
				diagnostics = {
					background = false,
				},
			})
			require("neomodern").load()
		end,
	},
	vague = {
		label = "vague",
		apply = function()
			load_plugin("vague.nvim")
			require("vague").setup({
				transparent = true,
			})
			vim.cmd.colorscheme("vague")
		end,
	},
}

local function read_saved()
	if vim.fn.filereadable(M.state_file) == 0 then
		return nil
	end
	local lines = vim.fn.readfile(M.state_file)
	local name = vim.trim(table.concat(lines, "\n"))
	return name ~= "" and name or nil
end

local function write_saved(name)
	vim.fn.mkdir(vim.fn.fnamemodify(M.state_file, ":h"), "p")
	vim.fn.writefile({ name }, M.state_file)
end

function M.available()
	local items = {}
	for name in pairs(M.themes) do
		table.insert(items, name)
	end

	table.sort(items)
	return items
end

function M.current()
	return vim.g.colors_name or M.default
end

function M.apply(name, save)
	if not name or name == "" then
		return false
	end

	local theme = M.themes[name]
	if not theme then
		vim.notify(("Theme '%s' is not registered"):format(name), vim.log.levels.ERROR, { title = "Theme" })
		return false
	end

	local ok, err = pcall(theme.apply)
	if not ok then
		vim.notify(("Theme '%s' failed: %s"):format(name, err), vim.log.levels.ERROR, { title = "Theme" })
		return false
	end

	apply_transparency()

	if save ~= false then
		write_saved(name)
	end

	vim.cmd("redrawstatus")
	return true
end

function M.apply_saved()
	local saved = read_saved()
	if not saved or saved == M.current() then
		return
	end
	M.apply(saved, false)
end

function M.pick()
	vim.ui.select(M.available(), { prompt = "Select colorscheme" }, function(choice)
		if choice then
			M.apply(choice, true)
		end
	end)
end

function M.setup()
	vim.api.nvim_create_user_command("Theme", function(opts)
		if opts.args == "" then
			M.pick()
			return
		end
		M.apply(opts.args, true)
	end, {
		nargs = "?",
		complete = function()
			return M.available()
		end,
		desc = "Pick or set colorscheme",
	})

	vim.api.nvim_create_user_command("ThemePick", function()
		M.pick()
	end, { desc = "Pick colorscheme" })

	vim.api.nvim_create_autocmd("User", {
		pattern = "VeryLazy",
		once = true,
		callback = function()
			M.apply_saved()
		end,
	})
end

return M
