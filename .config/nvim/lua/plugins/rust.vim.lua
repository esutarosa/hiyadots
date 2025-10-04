return {
	"rust-lang/rust.vim",
	ft = { "rust" },
	init = function()
		vim.g.rustfmt_autosave = true
	end,
}
