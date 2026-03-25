return {
	"neovim/nvim-lspconfig",
	opts = function(_, opts)
		opts.inlay_hints = { enabled = false }
		opts.servers = opts.servers or {}

		opts.servers.bashls = opts.servers.bashls or {}
		opts.servers.just = opts.servers.just or {}
		opts.servers.vimls = opts.servers.vimls or {}

		opts.servers.tailwindcss = vim.tbl_deep_extend("force", opts.servers.tailwindcss or {}, {
			settings = {
				tailwindCSS = {
					includeLanguages = {
						elixir = "html-eex",
						eelixir = "html-eex",
						heex = "html-eex",
					},
				},
			},
		})

		opts.servers.vtsls = vim.tbl_deep_extend("force", opts.servers.vtsls or {}, {
			settings = {
				typescript = {
					inlayHints = {
						parameterNames = { enabled = "literals" },
						parameterTypes = { enabled = true },
						variableTypes = { enabled = false },
						propertyDeclarationTypes = { enabled = true },
						functionLikeReturnTypes = { enabled = true },
						enumMemberValues = { enabled = true },
					},
				},
				javascript = {
					inlayHints = {
						parameterNames = { enabled = "all" },
						parameterTypes = { enabled = true },
						variableTypes = { enabled = true },
						propertyDeclarationTypes = { enabled = true },
						functionLikeReturnTypes = { enabled = true },
						enumMemberValues = { enabled = true },
					},
				},
			},
		})

		opts.servers.lua_ls = vim.tbl_deep_extend("force", opts.servers.lua_ls or {}, {
			single_file_support = true,
			settings = {
				Lua = {
					workspace = { checkThirdParty = false },
					completion = { workspaceWord = true, callSnippet = "Both" },
					hint = {
						enable = true,
						setType = false,
						paramType = true,
						paramName = "Disable",
						semicolon = "Disable",
						arrayIndex = "Disable",
					},
					doc = { privateName = { "^_" } },
					type = { castNumberToInteger = true },
					diagnostics = {
						disable = { "incomplete-signature-doc", "trailing-space" },
						groupSeverity = { strong = "Warning", strict = "Warning" },
						groupFileStatus = {
							ambiguity = "Opened",
							await = "Opened",
							codestyle = "None",
							duplicate = "Opened",
							global = "Opened",
							luadoc = "Opened",
							redefined = "Opened",
							strict = "Opened",
							strong = "Opened",
							["type-check"] = "Opened",
							unbalanced = "Opened",
							unused = "Opened",
						},
						unusedLocalExclude = { "_*" },
					},
					format = {
						enable = false,
						defaultConfig = {
							indent_style = "space",
							indent_size = "2",
							continuation_indent_size = "2",
						},
					},
				},
			},
		})

		opts.setup = opts.setup or {}

		local vtsls_setup = opts.setup.vtsls
		opts.setup.vtsls = function(server, server_opts)
			if vtsls_setup and vtsls_setup(server, server_opts) then
				return true
			end

			local on_attach = server_opts.on_attach
			server_opts.on_attach = function(client, buffer)
				client.server_capabilities.documentHighlightProvider = false
				if on_attach then
					on_attach(client, buffer)
				end
			end
		end
	end,
}
