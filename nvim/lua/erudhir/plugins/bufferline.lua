return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "BufEnter",
	-- event = { "BufReadPost", "BufAdd", "BufNewFile" },
	version = "*",
	keys = {
		{ "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
		{ "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
	},
	opts = {
		options = {
			mode = "tabs",
			show_buffer_close_icons = false,
			show_close_icons = false,
		},
	},
}
