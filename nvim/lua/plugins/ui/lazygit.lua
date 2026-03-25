return {
	"kdheepak/lazygit.nvim",
	keys = {
		{
			";c",
			":LazyGit<Return>",
			silent = true,
			noremap = true,
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}
