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
				"bash",
				"c",
				"cmake",
				"cpp",
				"css",
				"gitignore",
				"go",
				"graphql",
				"http",
				"php",
				"html",
				"just",
				"make",
				"yaml",
				"rust",
				"ron",
				"scss",
				"solidity",
				"sql",
				"svelte",
				"dockerfile",
				"hyprlang",
				"toml",
				"tsx",
				"vue",
				"tmux",
			}

			local installed = {}
			local seen = {}
			local disabled = {
				python = true,
				vim = true,
				tmux = true,
			}

			for _, lang in ipairs(opts.ensure_installed or {}) do
				if not disabled[lang] and not seen[lang] then
					seen[lang] = true
					table.insert(installed, lang)
				end
			end

			for _, lang in ipairs(base) do
				if not disabled[lang] and not seen[lang] then
					seen[lang] = true
					table.insert(installed, lang)
				end
			end

			for _, lang in ipairs(extra) do
				if not disabled[lang] and not seen[lang] then
					seen[lang] = true
					table.insert(installed, lang)
				end
			end

			opts.ensure_installed = installed

			opts.highlight = vim.tbl_deep_extend("force", { enable = true, disable = { "vim", "tmux" } }, opts.highlight or {})
			opts.indent = vim.tbl_deep_extend("force", { enable = true, disable = { "vim", "tmux" } }, opts.indent or {})

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

			vim.treesitter.language.register("markdown", "mdx")
			vim.treesitter.language.register("markdown", "markdown.mdx")

			return opts
		end,
	},
}
