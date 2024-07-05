return {
	{ "echasnovski/mini.bracketed", version = false, config = true },
	-- {
	-- 	"echasnovski/mini.surround",
	-- 	version = false,
	-- 	opts = {
	-- 		mappings = {
	-- 			add = "gsa", -- Add surrounding in Normal and Visual modes
	-- 			delete = "gsd", -- Delete surrounding
	-- 			find = "gsf", -- Find surrounding (to the right)
	-- 			find_left = "gsF", -- Find surrounding (to the left)
	-- 			highlight = "gsh", -- Highlight surrounding
	-- 			replace = "gsr", -- Replace surrounding
	-- 			update_n_lines = "gsn", -- Update `n_lines`
	-- 		},
	-- 	},
	-- },
	{
		"echasnovski/mini.hipatterns",
		version = false,
		config = function()
			local status, hipatterns = pcall(require, "mini.hipatterns")
			if not status then
				return
			end
			hipatterns.setup({
				highlighters = {
					-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
					fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
					hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

					-- Highlight hex color strings (`#rrggbb`) using that color
					hex_color = hipatterns.gen_highlighter.hex_color(),
				},
			})
		end,
	},
	-- {
	-- 	"echasnovski/mini.indentscope",
	-- 	version = false, -- wait till new 0.7.0 release to put it back on semver
	-- 	event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	-- 	opts = {
	-- 		-- symbol = "▏",
	-- 		symbol = "│",
	-- 		options = { try_as_border = true },
	-- 	},
	-- 	init = function()
	-- 		vim.api.nvim_create_autocmd("FileType", {
	-- 			pattern = {
	-- 				"help",
	-- 				"alpha",
	-- 				"dashboard",
	-- 				"tree",
	-- 				"Trouble",
	-- 				"trouble",
	-- 				"lazy",
	-- 				"mason",
	-- 				"notify",
	-- 				"toggleterm",
	-- 				"lazyterm",
	-- 			},
	-- 			callback = function()
	-- 				vim.b.miniindentscope_disable = true
	-- 			end,
	-- 		})
	-- 	end,
	-- },
}
