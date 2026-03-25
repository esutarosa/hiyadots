return {
	"mfussenegger/nvim-lint",
	opts = function(_, opts)
		opts = opts or {}
		opts.linters_by_ft = opts.linters_by_ft or {}
		opts.linters_by_ft.dotenv = {}
	end,
}
