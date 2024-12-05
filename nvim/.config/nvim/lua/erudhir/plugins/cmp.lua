return {
	"hrsh7th/nvim-cmp",
	version = false,
	event = "InsertEnter",
	dependencies = {
		"L3MON4D3/LuaSnip",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-path",
		"onsails/lspkind-nvim",
		"rafamadriz/friendly-snippets",
		"saadparwaiz1/cmp_luasnip",
	},

	config = function()
		local cmp = require("cmp")
		local lsp_kind = require("lspkind")

		lsp_kind.init()
		---@diagnostic disable-next-line
		cmp.setup({
			enabled = true,
			preselect = cmp.PreselectMode.None,
			window = {
				completion = cmp.config.window.bordered({
					winhighlight = "Normal:Normal,FloatBorder:LspBorderBG,CursorLine:PmenuSel,Search:None",
				}),
				documentation = cmp.config.window.bordered({
					winhighlight = "Normal:Normal,FloatBorder:LspBorderBG,CursorLine:PmenuSel,Search:None",
				}),
			},
			---@diagnostic disable-next-line
			view = {
				entries = "bordered",
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = {
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-p>"] = cmp.mapping.scroll_docs(-4),
				["<C-n>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-c>"] = cmp.mapping.close(),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}),
			},
			sources = {
				{ name = "nvim_lsp_signature_help", group_index = 1 },
				{ name = "luasnip", max_item_count = 5, group_index = 1 },
				{ name = "nvim_lsp", max_item_count = 20, group_index = 1 },
				{ name = "nvim_lua", group_index = 1 },
				{ name = "vim-dadbod-completion", group_index = 1 },
				{ name = "path", group_index = 2 },
				{ name = "buffer", keyword_length = 2, max_item_count = 5, group_index = 2 },
			},
		})
	end,
}
