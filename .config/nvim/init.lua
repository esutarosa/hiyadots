if vim.loader then
	vim.loader.enable()
end

_G.dd = function(...)
	require("util.debug").dump(...)
end
vim.print = _G.dd

vim.o.termguicolors = true

vim.api.nvim_create_augroup("TransparentBg", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
	group = "TransparentBg",
	callback = function()
		local hl = vim.api.nvim_set_hl
		hl(0, "Normal", { bg = "none" })
		hl(0, "NormalNC", { bg = "none" })
		hl(0, "SignColumn", { bg = "none" })
		hl(0, "CursorLine", { bg = "none" })
		hl(0, "EndOfBuffer", { bg = "none" })
	end,
})

require("config.lazy")
