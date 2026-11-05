if vim.loader then
	vim.loader.enable()
end

vim.o.termguicolors = true

require("util.theme").setup()
require("config.lazy")
