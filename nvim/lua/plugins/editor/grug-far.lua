return {
	"MagicDuck/grug-far.nvim",
	cmd = { "GrugFar", "GrugFarWithin" },
	opts = {
		transient = true,
	},
	keys = {
		{
			";r",
			function()
				require("grug-far").open()
			end,
			mode = "n",
			desc = "Find and replace",
		},
		{
			";r",
			function()
				require("grug-far").with_visual_selection()
			end,
			mode = "x",
			desc = "Find and replace selection",
		},
	},
}
