return {
	"folke/flash.nvim",
	keys = function()
		return {
			{
				"<leader>/",
				function()
					require("flash").jump()
				end,
				mode = { "n", "x", "o" },
				desc = "Flash",
			},
			{
				"<leader>?",
				function()
					require("flash").treesitter()
				end,
				mode = { "n", "x", "o" },
				desc = "Flash Treesitter",
			},
		}
	end,
	opts = {
		search = {
			forward = true,
			multi_window = false,
			wrap = false,
			incremental = true,
		},
	},
}
