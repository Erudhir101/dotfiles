return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
		config = function()
			-- import nvim-treesitter plugin
			local status, treesitter = pcall(require, "nvim-treesitter.configs")
			if not status then
				return
			end

			-- configure treesitter
			treesitter.setup({ -- enable syntax highlighting
				highlight = { enable = true },
				-- auto install above language parsers
				auto_install = true,
				-- enable indentation
				indent = { enable = true },
				-- enable autotagging (w/ nvim-ts-autotag plugin)
				autotag = { enable = true },
				-- ensure these language parsers are installed
				ensure_installed = {
					"bash",
					"c",
					"css",
					"dockerfile",
					"gitignore",
					"go",
					"graphql",
					"html",
					"java",
					"javascript",
					"json",
					"lua",
					"markdown",
					"markdown_inline",
					"prisma",
					"python",
					"rust",
					"svelte",
					"tsx",
					"typescript",
					"vim",
					"yaml",
				},
			})

			-- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
			require("ts_context_commentstring").setup({})
		end,
	},
}
