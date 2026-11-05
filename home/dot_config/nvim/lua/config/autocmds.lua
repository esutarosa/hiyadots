local group = vim.api.nvim_create_augroup("my_config", { clear = true })

vim.filetype.add({
	filename = {
		[".env"] = "dotenv",
	},
	pattern = {
		["%.env%.[%w_.-]+$"] = "dotenv",
	},
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = group,
	pattern = { ".env", ".env.*" },
	callback = function(args)
		vim.bo[args.buf].filetype = "dotenv"
	end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
	group = group,
	callback = function()
		vim.opt.paste = false
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = group,
	pattern = { "markdown" },
	callback = function()
		vim.opt_local.conceallevel = 0
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = group,
	pattern = { "dotenv" },
	callback = function(args)
		vim.bo[args.buf].syntax = "sh"
		vim.diagnostic.enable(false, { bufnr = args.buf })
		vim.schedule(function()
			for _, client in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
				vim.lsp.buf_detach_client(args.buf, client.id)
			end
		end)
	end,
})
