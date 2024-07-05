local kind_icons = {
	Text = " ",
	Method = " ",
	Function = " ",
	Constructor = " ",
	Field = " ",
	Variable = " ",
	Class = " ",
	Interface = " ",
	Module = " ",
	Property = " ",
	Unit = " ",
	Value = " ",
	Enum = " ",
	Keyword = " ",
	Snippet = " ",
	Color = " ",
	File = " ",
	Reference = " ",
	Folder = " ",
	EnumMember = " ",
	Constant = " ",
	Struct = " ",
	Event = " ",
	Operator = " ",
	TypeParameter = " ",
}

return {
	"hrsh7th/nvim-cmp",
	-- lazy = true,
	event = "InsertEnter",
	dependencies = {
		"L3MON4D3/LuaSnip", -- snippet engine
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		"onsails/lspkind.nvim", -- vs-code like pictograms
		"rafamadriz/friendly-snippets", -- useful snippets
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
	},
	config = function()
		local status, cmp = pcall(require, "cmp")
		if not status then
			return
		end

		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			-- completion = {
			-- 	completeopt = "menu,menuone,preview,noselect",
			-- },
			snippet = { -- configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-u>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<CR>"] = cmp.mapping.confirm({ select = true }),
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- snippets
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
			}),

			-- configure lspkind for vs-code like pictograms in completion menu
			formatting = {
				format = function(entry, vim_item)
					vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
					vim_item.menu = ({
						buffer = "[Buf]",
						nvim_lsp = "[LSP]",
						luasnip = "[Snip]",
						nvim_lua = "[Lua]",
						latex_symbols = "[Latex]",
					})[entry.source.name]
					return vim_item
				end,
				--  = {
				-- format = lspkind.cmp_format({
				-- 	maxwidth = 50,
				-- 	ellipsis_char = "...",
				-- 	mode = "symbol_text",
				-- 	show_labelDetails = true,
				-- 	menu = {
				-- 		buffer = "[Buffer]",
				-- 		nvim_lsp = "[LSP]",
				-- 		luasnip = "[LuaSnip]",
				-- 		nvim_lua = "[Lua]",
				-- 		latex_symbols = "[Latex]",
				-- 	},
				-- }),
			},
		})
	end,
}
