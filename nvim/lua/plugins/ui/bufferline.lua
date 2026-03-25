return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	keys = {
		{ "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
		{ "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
	},
	opts = function(_, opts)
		opts = opts or {}
		opts.options = opts.options or {}
		vim.api.nvim_set_hl(0, "TabLineFill", { bg = "NONE" })
		opts.highlights = vim.tbl_deep_extend("force", opts.highlights or {}, {
			fill = { bg = "none" },
			background = { bg = "none" },
			tab = { bg = "none" },
			tab_selected = { bg = "none" },
			tab_separator = { bg = "none" },
			tab_separator_selected = { bg = "none" },
			separator = { bg = "none" },
			separator_selected = { bg = "none" },
			separator_visible = { bg = "none" },
			offset_separator = { bg = "none" },
		})
		opts.options.mode = "tabs"
		opts.options.show_buffer_close_icons = false
		opts.options.show_close_icon = false
		return opts
	end,
}
