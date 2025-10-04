return {
	"mrcjkb/rustaceanvim",
	ft = { "rust" },
	lazy = true,
	opts = function(_, opts)
		opts = opts or {}
		return vim.tbl_extend("force", opts, {
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
