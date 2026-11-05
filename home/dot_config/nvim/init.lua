if vim.loader then
	vim.loader.enable()
end

vim.o.termguicolors = true

vim.api.nvim_create_augroup("TransparentBg", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
	group = "TransparentBg",
	callback = function()
		local hl = vim.api.nvim_set_hl
		hl(0, "Normal", { bg = "none" })
		hl(0, "NormalNC", { bg = "none" })
		hl(0, "SnacksDashboardNormal", { bg = "none" })
		hl(0, "SignColumn", { bg = "none" })
		hl(0, "StatusColumn", { bg = "none" })
		hl(0, "LineNr", { bg = "none" })
		hl(0, "CursorLineNr", { bg = "none" })
		hl(0, "FoldColumn", { bg = "none" })
		hl(0, "CursorLineSign", { bg = "none" })
		hl(0, "CursorLineFold", { bg = "none" })
		hl(0, "CursorLine", { bg = "none" })
		hl(0, "EndOfBuffer", { bg = "none" })
	end,
})

require("util.theme").setup()
require("config.lazy")
