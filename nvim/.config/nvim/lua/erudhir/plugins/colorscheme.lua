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
	-- 		rose.setup({})
	-- 		-- load the colorscheme here
	-- 		vim.cmd("colorscheme rose-pine")
	-- 	end,
	-- },
	-- {
	-- 	"Mofiqul/dracula.nvim",
	-- 	config = function()
	-- 		local status, dracula = pcall(require, "dracula")
	-- 		if not status then
	-- 			return
	-- 		end
	--
	-- 		dracula.setup()
	-- 		vim.cmd([[colorscheme dracula]])
	-- 	end,
	-- },
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		local status, tokyonight = pcall(require, "tokyonight")
	-- 		local colors = require("tokyonight.colors").setup()
	-- 		if not status then
	-- 			return
	-- 		end
	-- 		tokyonight.setup({
	-- 			style = "night",
	-- 		})
	-- 		vim.cmd([[colorscheme tokyonight]])
	-- 	end,
	-- },
	{
		"catppuccin/nvim",
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			local status, catppuccin = pcall(require, "catppuccin")
			if not status then
				return
			end
			catppuccin.setup({
				color_overrides = {
					mocha = {
						-- red = "#ef233c",
						-- pink = "#ff007c",
						-- peach = "#ff9e64",
						-- green = "#4fd6be",
						-- mauve = "#c77dff",
						-- lavender = "#f4acb7",
						-- blue = "#00b4d8",
						-- base = "#000000",
					},
				},
			})
			-- load the colorscheme here
			vim.cmd([[colorscheme catppuccin]])
		end,
	},
	--
	--
	-- {
	-- 	"craftzdog/solarized-osaka.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		local status, osaka = pcall(require, "solarized-osaka")
	-- 		if not status then
	-- 			return
	-- 		end
	--
	-- 		osaka.setup({
	-- 			transparent = false,
	-- 		})
	--
	-- 		vim.cmd([[colorscheme solarized-osaka]])
	-- 	end,
	-- },
}
