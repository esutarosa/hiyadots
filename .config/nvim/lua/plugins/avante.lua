return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		provider = "openai",
		providers = {
			openai = {
				endpoint = "https://api.openai.com/v1",
				model = "gpt-5",
				api_key_name = "OPENAI_API_KEY",
				timeout = 120000,
				temperature = 0.7,
			},
		},
		windows = {
			sidebar = {
				enabled = true,
				position = "right",
				width = 42,
				border = "rounded",
			},
		},
		ui = {
			input = { border = "rounded", prompt = "󱚣 " },
			float = { border = "rounded" },
			notify = { level = "INFO" },
		},
		context = {
			provider = "git",
			include_current = true,
			max_files = 20,
		},
	},
}
