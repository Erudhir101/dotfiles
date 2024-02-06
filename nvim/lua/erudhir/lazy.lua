local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("erudhir.plugins", {
	-- defaults = { lazy = true },
	version = "*",
	install = { colorscheme = { "catppuccin" } },
	-- install = { missing = 300, colorscheme = { "catppuccin" } },
	checker = { enabled = true, notify = false },
	change_detection = {
		notify = false,
	},
	performance = {
		cache = {
			enabled = true,
			-- path = vim.fn.stdpath("cache") .. "/lazy/cache",
			-- disable_events = { "UIEnter, BufReadPre" },
		},
		reset_packpath = true,
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrw",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
		debug = false,
	},
})
