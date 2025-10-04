return {
	"supermaven-inc/supermaven-nvim",
	event = "InsertEnter",
	cmd = {
		"SupermavenUseFree",
	},
	opts = {
		keymaps = {
			accept_suggestion = "<C-l>",
			clear_suggestion = "<C-]>",
			accept_word = "<M-l>",
			accept_line = "<M-S-l>",
			next_word = "<M-]>",
			prev_word = "<M-[>",
		},
		ignore_filetypes = {
			"bigfile",
			"snacks_input",
			"snacks_notif",
		},
	},
}
