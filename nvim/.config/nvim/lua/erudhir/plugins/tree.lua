return {
	"nvim-tree/nvim-tree.lua",
	-- enabled = false,
	lazy = "VeryLazy",
	keys = { "<leader>e" },
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		local keymap = vim.keymap
		local status, tree = pcall(require, "nvim-tree")
		if not status then
			return
		end
		tree.setup({
			auto_reload_on_write = true,
			disable_netrw = false,
			hijack_cursor = false,
			hijack_netrw = true,
			hijack_unnamed_buffer_when_opening = false,
			open_on_tab = false,
			sort_by = "name",
			update_cwd = false,
			view = {
				width = 30,
				side = "left",
				preserve_window_proportions = false,
				number = false,
				relativenumber = false,
				signcolumn = "yes",
			},
			renderer = {
				indent_markers = {
					enable = false,
					icons = {
						corner = "└ ",
						edge = "│ ",
						none = "  ",
					},
				},
				icons = {
					webdev_colors = true,
				},
			},
			hijack_directories = {
				enable = true,
				auto_open = true,
			},
			update_focused_file = {
				enable = false,
				update_cwd = false,
				ignore_list = {},
			},
			system_open = {
				cmd = "",
				args = {},
			},
			diagnostics = {
				enable = false,
				show_on_dirs = false,
				icons = {
					hint = "",
					info = "",
					warning = "",
					error = "",
				},
			},
			filters = {
				dotfiles = false,
				custom = {},
				exclude = {},
			},
			git = {
				enable = true,
				ignore = true,
				timeout = 400,
			},
			actions = {
				use_system_clipboard = true,
				change_dir = {
					enable = true,
					global = false,
					restrict_above_cwd = false,
				},
				open_file = {
					quit_on_open = true,
					resize_window = false,
					window_picker = {
						enable = true,
						chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
						exclude = {
							filetype = { "notify", "qf", "diff", "fugitive", "fugitiveblame" },
							buftype = { "nofile", "terminal", "help" },
						},
					},
				},
			},
			trash = {
				cmd = "trash",
				require_confirm = true,
			},
			log = {
				enable = false,
				truncate = false,
				types = {
					all = false,
					config = false,
					copy_paste = false,
					diagnostics = false,
					git = false,
					profile = false,
				},
			},
		})

		local api = require("nvim-tree.api")
		keymap.set("n", "<space>e", api.tree.toggle, { silent = true, desc = "toggle nvim-tree" })
		keymap.set("n", "<C-]>", api.tree.change_root_to_node, { silent = true, desc = "gonna folder children" })
		keymap.set("n", "<C-[>", api.tree.change_root_to_parent, { silent = true, desc = "gonna folder parent" })
	end,
}
