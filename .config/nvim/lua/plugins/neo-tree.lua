return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
	event = "VeryLazy",
	opts = {
		close_if_last_window = true,
		window = {
			width = 64,
			mappings = {
				["t"] = "open_tabnew",
				["P"] = {
					"toggle_preview",
					config = {
						use_float = true,
					},
				},
				["zp"] = {
					"toggle_preview",
					config = {
						use_float = false,
					},
				},
				["v"] = "add_to_clipboard",
				["V"] = "clear_clipboard",
				["x"] = "cut_to_clipboard",
				["y"] = "copy_to_clipboard",
				["p"] = "paste_from_clipboard",
				["m"] = { "move", config = { show_path = "relative" } },
				["c"] = { "copy", config = { show_path = "relative" } },
				["go"] = function(state)
					local node = state.tree:get_node()
					if not node then
						return
					end
					local path = node:get_id()
					local is_dir = node.type == "directory"
					if vim.fn.has("mac") == 1 then
						if is_dir then
							vim.fn.jobstart({ "open", path }, { detach = true })
						else
							vim.fn.jobstart({ "open", "-R", path }, { detach = true })
						end
					elseif vim.fn.has("win32") == 1 then
						if is_dir then
							vim.fn.jobstart({ "explorer", path }, { detach = true })
						else
							vim.fn.jobstart({ "explorer", "/select,", path }, { detach = true })
						end
					else
						local target = is_dir and path or vim.fn.fnamemodify(path, ":h")
						vim.fn.jobstart({ "xdg-open", target }, { detach = true })
					end
				end,
			},
		},
		source_selector = { winbar = true, sources = { { source = "filesystem" } } },
		filesystem = {
			follow_current_file = { enabled = true },
			filtered_items = {
				visible = false,
				hide_dotfiles = false,
				hide_gitignored = false,
				hide_hidden = true,
				hide_by_name = { ".DS_Store", "DS_Store", ".git", ".next", "node_modules" },
				hide_by_pattern = { "**/.DS_Store", "**/.git/*", "**/.next/*", "**/node_modules/*" },
			},
		},
		event_handlers = {
			{
				event = "vim_buffer_enter",
				handler = function()
					if vim.bo.filetype == "neo-tree" then
						vim.cmd([[setlocal fillchars=eob:\ ]])
					end
				end,
			},
		},
	},
	config = function(_, opts)
		require("neo-tree").setup(opts)

		local function clear_bg(groups)
			for _, g in ipairs(groups) do
				vim.api.nvim_set_hl(0, g, { bg = "NONE" })
			end
		end

		clear_bg({
			"NeoTreeNormal",
			"NeoTreeNormalNC",
			"NeoTreeEndOfBuffer",
			"NeoTreeCursorLine",
			"NeoTreeSignColumn",
			"NeoTreeWinSeparator",
			"NeoTreeTabActive",
			"NeoTreeTabInactive",
			"NeoTreeTabSeparatorActive",
			"NeoTreeTabSeparatorInactive",
			"NeoTreeTitleBar",
			"NormalFloat",
			"FloatBorder",
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "neo-tree", "neo-tree-preview" },
			callback = function()
				vim.wo.winhighlight =
					"Normal:NeoTreeNormal,NormalNC:NeoTreeNormalNC,EndOfBuffer:NeoTreeEndOfBuffer,SignColumn:NeoTreeSignColumn,CursorLine:NeoTreeCursorLine,WinSeparator:NeoTreeWinSeparator"
				vim.cmd("setlocal fillchars=eob:\\ ")
			end,
		})
	end,
}
