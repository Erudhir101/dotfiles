return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- event = "BufEnter",
	event = "VeryLazy",
	opts = {
		options = {
			show_buffer_close_icons = false,
			show_close_icons = false,
		},
	},
}
