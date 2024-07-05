return {
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		lazy = false, -- As https://github.com/nvimdev/dashboard-nvim/pull/450, dashboard-nvim shouldn't be lazy-loaded to properly handle stdin.
		opts = function()
			local lazy = require("lazy")
			local logo = [[                                                        
                                                                           
             ████ ██████           █████      ██                     
            ███████████             █████                             
            █████████ ███████████████████ ███   ██████████   
           █████████  ███    █████████████ █████ █████████████   
          █████████ ██████████ █████████ █████ █████ ████ ████   
        ███████████ ███    ███ █████████ █████ █████ ████ ████  
       ██████  █████████████████████ ████ █████ █████ ████ █████ 
                                                                             
                                                                             ]]
			logo = string.rep("\n", 3) .. logo .. "\n\n"

			local opts = {
				theme = "doom",
				hide = {
					statusline = false,
				},
				config = {
					header = vim.split(logo, "\n"),
        -- stylua: ignore
        center = {
          { action = "ene | startinsert",                              desc = " New File",        icon = " ", key = "n" },
          -- { action = 'lua LazyVim.pick("oldfiles")()',                 desc = " Recent Files",    icon = " ", key = "r" },
          -- { action = 'lua LazyVim.pick.config_files()()',              desc = " Config",          icon = " ", key = "c" },
          -- { action = 'lua require("persistence").load()',              desc = " Restore Session", icon = " ", key = "s" },
          { action = "Lazy",                                           desc = " Lazy",            icon = "󰒲 ", key = "l" },
          { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit",            icon = " ", key = "q" },
        },
					footer = function()
						local stats = require("lazy").stats()
						local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
						local version = "v"
							.. vim.version().major
							.. "."
							.. vim.version().minor
							.. "."
							.. vim.version().patch
						return {
							"⚡ Loaded "
								.. stats.loaded
								.. "|"
								.. stats.count
								.. " plugins in "
								.. ms
								.. "ms"
								.. " | "
								.. version,
						}
					end,
				},
			}

			for _, button in ipairs(opts.config.center) do
				button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
				button.key_format = "  %s"
			end

			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "DashboardLoaded",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			return opts
		end,
	},
}
