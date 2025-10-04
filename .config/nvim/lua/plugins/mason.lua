return {
	"mason-org/mason.nvim",
	opts = function(_, opts)
		opts = opts or {}
		opts.ensure_installed = opts.ensure_installed or {}
		vim.list_extend(opts.ensure_installed, {
			"stylua",
			"selene",
			"luacheck",
			"shellcheck",
			"shfmt",
			"tailwindcss-language-server",
			"typescript-language-server",
			"astro-language-server",
			"css-lsp",
			"vue-language-server",
		})
	end,
}
