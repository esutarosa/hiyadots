return {
	"jake-stewart/multicursor.nvim",
	branch = "1.0",
	config = function()
		local mc = require("multicursor-nvim")
		local set = vim.keymap.set

		mc.setup()

		set({ "n", "x" }, "<C-n>", function()
			mc.matchAddCursor(1)
		end, { desc = "Multi-cursor: add next match" })
		set({ "n", "x" }, "<C-p>", function()
			mc.matchAddCursor(-1)
		end, { desc = "Multi-cursor: add previous match" })
		set({ "n", "x" }, "<leader>mi", mc.toggleCursor, { desc = "Multi-cursor: toggle cursor" })

		mc.addKeymapLayer(function(layer_set)
			layer_set({ "n", "x" }, "<left>", mc.prevCursor)
			layer_set({ "n", "x" }, "<right>", mc.nextCursor)
			layer_set("n", "<esc>", function()
				if not mc.cursorsEnabled() then
					mc.enableCursors()
				else
					mc.clearCursors()
				end
			end)
		end)

		local hl = vim.api.nvim_set_hl
		hl(0, "MultiCursorCursor", { reverse = true })
		hl(0, "MultiCursorVisual", { link = "Visual" })
		hl(0, "MultiCursorSign", { link = "SignColumn" })
		hl(0, "MultiCursorMatchPreview", { link = "Search" })
		hl(0, "MultiCursorDisabledCursor", { reverse = true })
		hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
		hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
	end,
}
