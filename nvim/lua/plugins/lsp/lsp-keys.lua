return {
	"neovim/nvim-lspconfig",
	opts = function(_, opts)
		opts = opts or {}
		opts.servers = opts.servers or {}

		opts.servers["*"] = opts.servers["*"] or {}
		opts.servers["*"].keys = opts.servers["*"].keys or {}

		table.insert(opts.servers["*"].keys, {
			"gd",
			function()
				require("telescope.builtin").lsp_definitions({ reuse_win = false })
			end,
			desc = "Goto Definition",
			has = "definition",
		})
	end,
}
