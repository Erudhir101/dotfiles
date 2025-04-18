return {
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		config = function()
			local status, flash = pcall(require, "flash")
			if not status then
				return
			end
			flash.setup({
				search = {
					mode = "search",
				},
				char = {
					enabled = false,
				},
			})
		end,

		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash Jump",
			},
			{
				";s",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
		},
	},
}
