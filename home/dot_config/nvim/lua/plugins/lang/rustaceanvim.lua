return {
	"mrcjkb/rustaceanvim",
	ft = { "rust" },
	lazy = true,
	opts = function(_, opts)
		local rustfmt_config = vim.fs.joinpath(vim.fn.stdpath("config"), "rustfmt.toml")

		opts = opts or {}
		return vim.tbl_deep_extend("force", opts, {
			server = {
				default_settings = {
					["rust-analyzer"] = {
						rustfmt = {
							overrideCommand = {
								"rustup",
								"run",
								"nightly",
								"rustfmt",
								"--config-path",
								rustfmt_config,
							},
						},
					},
				},
			},
			tools = {
				inlay_hints = {
					auto = true,
					show_parameter_hints = false,
					parameter_hints_prefix = "  󰮹 ",
					only_current_line = true,
					other_hints_prefix = "  󰮺 ",
				},
			},
		})
	end,
}
