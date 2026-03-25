return {
	"stevearc/conform.nvim",
	optional = true,
	opts = function(_, opts)
		opts = opts or {}
		opts.formatters = opts.formatters or {}
		opts.formatters_by_ft = opts.formatters_by_ft or {}

		opts.formatters.prettier_markdown = vim.tbl_deep_extend(
			"force",
			require("conform.formatters.prettier"),
			{
				prepend_args = { "--prose-wrap", "always", "--print-width", "80" },
				options = {
					ft_parsers = {
						markdown = "markdown",
						["markdown.mdx"] = "mdx",
					},
				},
			}
		)

		opts.formatters_by_ft.c = { "clang-format" }
		opts.formatters_by_ft.cpp = { "clang-format" }
		opts.formatters_by_ft.toml = { "taplo" }
		opts.formatters_by_ft.markdown = { "prettier_markdown", "markdownlint-cli2", "markdown-toc" }
		opts.formatters_by_ft["markdown.mdx"] = { "prettier_markdown", "markdownlint-cli2", "markdown-toc" }
		return opts
	end,
}
