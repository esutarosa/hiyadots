return {
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		opts = {},
	},
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			opts = opts or {}
			opts.servers = opts.servers or {}
			opts.servers["*"] = opts.servers["*"] or {}
			opts.servers["*"].keys = opts.servers["*"].keys or {}

			table.insert(opts.servers["*"].keys, {
				"<leader>cr",
				function()
					local ok, inc_rename = pcall(require, "inc_rename")
					if not ok then
						pcall(require("lazy").load, { plugins = { "inc-rename.nvim" } })
						inc_rename = require("inc_rename")
					end
					return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
				end,
				expr = true,
				desc = "Rename (inc-rename.nvim)",
				has = "rename",
			})
		end,
	},
	{
		"folke/noice.nvim",
		optional = true,
		opts = {
			presets = { inc_rename = true },
		},
	},
}
