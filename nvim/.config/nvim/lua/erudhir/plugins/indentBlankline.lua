return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPost" },
	main = "ibl",
	opts = { exclude = { filetypes = { "dashboard", "nvimTree" } } },
}
