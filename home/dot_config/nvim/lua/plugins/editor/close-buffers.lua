return {
	"kazhala/close-buffers.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<leader>th",
			function()
				require("close_buffers").delete({ type = "hidden" })
			end,
			"Close hidden buffers",
		},
		{
			"<leader>tu",
			function()
				require("close_buffers").delete({ type = "nameless" })
			end,
			"Close nameless buffers",
		},
	},
}
