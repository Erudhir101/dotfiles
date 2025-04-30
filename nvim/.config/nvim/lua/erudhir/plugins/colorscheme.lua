return {
	-- {
	-- 	"rose-pine/neovim",
	-- 	name = "rose-pine",
	-- 	priority = 1000,
	-- 	lazy = false,
	-- 	config = function()
	-- 		local status, rose = pcall(require, "rose-pine")
	-- 		if not status then
	-- 			return
	-- 		end
	--
	-- 		rose.setup({
	-- 			highlight_groups = {
	-- 				CurSearch = { fg = "base", bg = "leaf", inherit = false },
	-- 				Search = { fg = "text", bg = "leaf", blend = 20, inherit = false },
	-- 			},
	-- 		})
	-- 		-- load the colorscheme here
	-- 		vim.cmd("colorscheme rose-pine")
	-- 	end,
	-- },
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			local status, tokyonight = pcall(require, "tokyonight")
			if not status then
				return
			end
			tokyonight.setup({
				style = "night",
			})
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
}
