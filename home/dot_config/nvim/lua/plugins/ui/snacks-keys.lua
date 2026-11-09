return {
	"folke/snacks.nvim",
	keys = {
		{ "<leader>e", false },
		{ "<leader>fe", false },
		{
			"<leader>fP",
			function()
				Snacks.picker.files({ cwd = require("lazy.core.config").options.root })
			end,
			desc = "Find plugin file",
		},
		{
			";f",
			function()
				Snacks.picker.files({ hidden = true })
			end,
			desc = "Find files",
		},
		{
			";g",
			function()
				Snacks.picker.grep({ hidden = true })
			end,
			desc = "Grep",
		},
		{
			"\\\\",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			";;",
			function()
				Snacks.picker.resume()
			end,
			desc = "Resume the previous picker",
		},
		{
			";e",
			function()
				vim.cmd("Trouble diagnostics toggle focus=true win.position=bottom")
			end,
			desc = "Diagnostics",
		},
		{
			";s",
			function()
				if #vim.lsp.get_clients({ bufnr = 0, method = "textDocument/documentSymbol" }) > 0 then
					Snacks.picker.lsp_symbols()
				else
					Snacks.picker.treesitter()
				end
			end,
			desc = "Symbols",
		},
		{
			";c",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"sf",
			function()
				Snacks.picker.explorer({
					cwd = vim.fn.expand("%:p:h"),
					hidden = true,
					ignored = true,
					auto_close = true,
					jump = { close = true },
					layout = { preset = "dropdown", preview = false },
					win = { list = { keys = { N = "explorer_add", h = "explorer_up" } } },
				})
			end,
			desc = "File browser at the current buffer",
		},
		{
			"<leader>th",
			function()
				Snacks.bufdelete({
					filter = function(buf)
						return vim.fn.getbufinfo(buf)[1].hidden == 1
					end,
				})
			end,
			desc = "Close hidden buffers",
		},
		{
			"<leader>tu",
			function()
				Snacks.bufdelete({
					filter = function(buf)
						return vim.api.nvim_buf_get_name(buf) == ""
					end,
				})
			end,
			desc = "Close nameless buffers",
		},
	},
}
