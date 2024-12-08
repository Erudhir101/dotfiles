return {
	{
		"echasnovski/mini.pairs",
		version = false,
		event = "VeryLazy",
		config = function()
			local status, pairs = pcall(require, "mini.pairs")
			if not status then
				return
			end
			pairs.setup({
				-- skip autopair when next character is one of these
				skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
				-- skip autopair when the cursor is inside these treesitter nodes
				skip_ts = { "string" },
				-- skip autopair when next character is closing pair
				-- and there are more closing pairs than opening pairs
				skip_unbalanced = true,
				-- better deal with markdown code blocks
				markdown = true,
			})
		end,
	},
	{
		"echasnovski/mini.bracketed",
		version = false,
		event = "VeryLazy",
		config = function()
			local status, bracketed = pcall(require, "mini.bracketed")
			if not status then
				return
			end

			bracketed.setup({
				buffer = { suffix = "b", options = {} }, -- using cybu
				comment = { suffix = "c", options = {} },
				conflict = { suffix = "x", options = {} },
				-- don't want diagnostic float focus, have in mappings.lua with coc
				-- support too
				diagnostic = { suffix = "d", options = {} },
				file = { suffix = "", options = {} },
				indent = { suffix = "", options = {} }, -- confusing
				jump = { suffix = "", options = {} }, -- redundant
				location = { suffix = "l", options = {} },
				oldfile = { suffix = "o", options = {} },
				quickfix = { suffix = "q", options = {} },
				treesitter = { suffix = "t", options = {} },
				undo = { suffix = "", options = {} },
				window = { suffix = "", options = {} }, -- broken going to unlisted
				yank = { suffix = "", options = {} }, -- confusing
			})
		end,
	},
}
