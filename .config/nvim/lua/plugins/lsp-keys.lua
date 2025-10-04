return {
	"neovim/nvim-lspconfig",
	opts = function()
		local keys = require("lazyvim.plugins.lsp.keymaps").get()
		vim.list_extend(keys, {
			{
				"gd",
				function()
					require("telescope.builtin").lsp_definitions({ reuse_win = false })
				end,
				desc = "Goto Definition",
				has = "definition",
			},
		})
	end,
}
