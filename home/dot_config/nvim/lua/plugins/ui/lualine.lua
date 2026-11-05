return {
	"nvim-lualine/lualine.nvim",
	opts = function(_, opts)
		local LazyVim = require("lazyvim.util")
		local theme = require("lualine.themes.auto")
		local function not_neo_tree()
			return vim.bo.filetype ~= "neo-tree"
		end
		local function format_size(bytes)
			if not bytes or bytes < 0 then
				return ""
			end
			if bytes < 1024 then
				return string.format("%dB", bytes)
			end
			if bytes < 1024 * 1024 then
				return string.format("%.1fKB", bytes / 1024)
			end
			return string.format("%.1fMB", bytes / (1024 * 1024))
		end
		local function file_stats()
			local lines = vim.api.nvim_buf_line_count(0)
			local path = vim.api.nvim_buf_get_name(0)
			if path == "" then
				return string.format("%dL", lines)
			end
			local stat = vim.uv.fs_stat(path)
			local size = format_size(stat and stat.size or nil)
			return size ~= "" and string.format("%dL %s", lines, size) or string.format("%dL", lines)
		end

		for _, mode in pairs(theme) do
			for _, section_name in ipairs({ "b", "c", "x", "y", "z" }) do
				local section = mode[section_name]
				if type(section) == "table" then
					section.bg = "none"
				end
			end
		end

		opts.options.theme = theme
		opts.options.component_separators = { left = "", right = "" }
		opts.options.section_separators = { left = "", right = "" }
		vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })
		opts.sections.lualine_a = {}
		opts.sections.lualine_b = { "branch" }
		local root_dir = LazyVim.lualine.root_dir()
		root_dir.cond = function()
			return not_neo_tree()
		end
		opts.sections.lualine_c[1] = root_dir

		opts.sections.lualine_c[4] = {
			LazyVim.lualine.pretty_path({
				length = 0,
				relative = "cwd",
				modified_hl = "MatchParen",
				directory_hl = "",
				filename_hl = "Bold",
				modified_sign = "",
				readonly_icon = " 󰌾 ",
			}),
			cond = not_neo_tree,
		}

		opts.sections.lualine_y = {
			{
				file_stats,
				cond = not_neo_tree,
				padding = { left = 1, right = 1 },
			},
			{ "progress", separator = "", padding = { left = 1, right = 1 } },
			{
				"location",
				padding = { left = 1, right = 1 },
				color = { gui = "bold" },
			},
		}
		opts.sections.lualine_z = {}
		opts.extensions = { "lazy", "fzf" }
	end,
}
