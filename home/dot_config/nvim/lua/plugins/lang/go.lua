return {
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			opts = opts or {}
			opts.servers = opts.servers or {}

			opts.servers.gopls = vim.tbl_deep_extend("force", opts.servers.gopls or {}, {
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
						usePlaceholders = true,
						completeUnimported = true,
						gofumpt = true,
					},
				},
			})

			return opts
		end,
	},
}
