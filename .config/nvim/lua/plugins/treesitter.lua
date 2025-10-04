return {
	{
		"nvim-treesitter/playground",
		cmd = "TSPlaygroundToggle",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		opts = function(_, opts)
			local base = {
				"lua",
				"vim",
				"vimdoc",
				"regex",
				"markdown",
				"markdown_inline",
			}

			local extra = {
				"typescript",
				"javascript",
				"astro",
				"cmake",
				"cpp",
				"css",
				"gitignore",
				"go",
				"graphql",
				"http",
				"php",
				"html",
				"yaml",
				"rust",
				"ron",
				"scss",
				"sql",
				"svelte",
				"dockerfile",
				"hyprlang",
				"vue",
				"tmux",
			}

			opts.ensure_installed = vim.tbl_extend("force", opts.ensure_installed or {}, base, extra)

			opts.highlight = vim.tbl_deep_extend("force", { enable = true }, opts.highlight or {})
			opts.indent = vim.tbl_deep_extend("force", { enable = true }, opts.indent or {})

			opts.query_linter = {
				enable = true,
				use_virtual_text = true,
				lint_events = { "BufWrite", "CursorHold" },
			}

			opts.playground = vim.tbl_deep_extend("force", {
				enable = true,
				updatetime = 25,
				persist_queries = true,
				keybindings = {
					toggle_query_editor = "o",
					toggle_hl_groups = "i",
					toggle_injected_languages = "t",
					toggle_anonymous_nodes = "a",
					toggle_language_display = "I",
					focus_language = "f",
					unfocus_language = "F",
					update = "R",
					goto_node = "<cr>",
					show_help = "?",
				},
			}, opts.playground or {})

			vim.filetype.add({ extension = { mdx = "mdx" } })
			vim.treesitter.language.register("markdown", "mdx")

			return opts
		end,
	},
}
