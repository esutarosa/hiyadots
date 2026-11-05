return {
	"nvim-treesitter/nvim-treesitter",
	opts = function(_, opts)
		local disabled = { python = true, vim = true, tmux = true }

		vim.list_extend(opts.ensure_installed, {
			"astro",
			"cmake",
			"cpp",
			"css",
			"gitignore",
			"graphql",
			"http",
			"php",
			"just",
			"make",
			"rust",
			"ron",
			"scss",
			"solidity",
			"sql",
			"svelte",
			"dockerfile",
			"hyprlang",
			"toml",
			"vue",
		})
		local seen = {}
		opts.ensure_installed = vim.tbl_filter(function(lang)
			local keep = not disabled[lang] and not seen[lang]
			seen[lang] = true
			return keep
		end, opts.ensure_installed)

		opts.highlight = vim.tbl_deep_extend("force", opts.highlight or {}, { disable = { "vim", "tmux" } })
		opts.indent = vim.tbl_deep_extend("force", opts.indent or {}, { disable = { "vim", "tmux" } })

		vim.treesitter.language.register("markdown", "mdx")
		vim.treesitter.language.register("markdown", "markdown.mdx")
	end,
}
