return {
	enabled = false,
	"mikavilpas/yazi.nvim",
	event = "VeryLazy",
	keys = {
		{
			-- Open in the current working directory
			"<leader>e",
			"<cmd>Yazi cwd<cr>",
			desc = "Open the file manager in nvim's working directory",
		},
		{
			"<c-up>",
			"<cmd>Yazi toggle<cr>",
			desc = "Resume the last yazi session",
		},
		opts = {
			-- if you want to open yazi instead of netrw, see below for more info
			open_for_directories = false,
			keymaps = {
				show_help = "<f1>",
			},
		},
	},
}
