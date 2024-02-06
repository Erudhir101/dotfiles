return {
	{
		"catppuccin/nvim",
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			local status, colorTheme = pcall(require, "catppuccin")
			if not status then
				return
			end
			colorTheme.setup({
				transparent_background = true, -- disables setting the background color.
			})
			-- load the colorscheme here
			vim.cmd([[colorscheme catppuccin]])
		end,
	},
}
