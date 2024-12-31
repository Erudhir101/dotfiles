-- return {
-- 	"hrsh7th/nvim-cmp",
-- 	event = "VeryLazy",
-- 	dependencies = {
-- 		{
-- 			"L3MON4D3/LuaSnip",
-- 			build = (function()
-- 				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
-- 					return
-- 				end
-- 				return "make install_jsregexp"
-- 			end)(),
-- 			dependencies = {
-- 				{
-- 					"rafamadriz/friendly-snippets",
-- 					config = function()
-- 						require("luasnip.loaders.from_vscode").lazy_load()
-- 					end,
-- 				},
-- 			},
-- 		},
-- 		"saadparwaiz1/cmp_luasnip",
-- 		"hrsh7th/cmp-nvim-lsp",
-- 		"hrsh7th/cmp-buffer",
-- 		"hrsh7th/cmp-path",
-- 	},
--
-- 	config = function()
-- 		local cmp = require("cmp")
-- 		local luasnip = require("luasnip")
-- 		luasnip.config.setup({})
--
-- 		local kind_icons = {
-- 			Text = "󰉿",
-- 			Method = "m",
-- 			Function = "󰊕",
-- 			Constructor = "",
-- 			Field = "",
-- 			Variable = "󰆧",
-- 			Class = "󰌗",
-- 			Interface = "",
-- 			Module = "",
-- 			Property = "",
-- 			Unit = "",
-- 			Value = "󰎠",
-- 			Enum = "",
-- 			Keyword = "󰌋",
-- 			Snippet = "",
-- 			Color = "󰏘",
-- 			File = "󰈙",
-- 			Reference = "",
-- 			Folder = "󰉋",
-- 			EnumMember = "",
-- 			Constant = "󰇽",
-- 			Struct = "",
-- 			Event = "",
-- 			Operator = "󰆕",
-- 			TypeParameter = "󰊄",
-- 		}
-- 		cmp.setup({
-- 			window = { completion = cmp.config.window.bordered({ border = "single" }) },
-- 			snippet = {
-- 				expand = function(args)
-- 					luasnip.lsp_expand(args.body)
-- 				end,
-- 			},
-- 			completion = { completeopt = "menu,menuone,noinsert" },
--
-- 			-- For an understanding of why these mappings were
-- 			-- chosen, you will need to read `:help ins-completion`
-- 			--
-- 			-- No, but seriously. Please read `:help ins-completion`, it is really good!
-- 			mapping = cmp.mapping.preset.insert({
-- 				["<C-j>"] = cmp.mapping.select_next_item(),
-- 				["<C-k>"] = cmp.mapping.select_prev_item(),
-- 				["<C-p>"] = cmp.mapping.scroll_docs(-4),
-- 				["<C-n>"] = cmp.mapping.scroll_docs(4),
-- 				["<CR>"] = cmp.mapping.confirm({ select = true }),
-- 				["<C-Space>"] = cmp.mapping.complete({}),
-- 			}),
-- 			sources = {
-- 				{
-- 					name = "lazydev",
-- 					-- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
-- 					group_index = 0,
-- 				},
-- 				{ name = "nvim_lsp" },
-- 				{ name = "luasnip" },
-- 				{ name = "buffer" },
-- 				{ name = "path" },
-- 			},
-- 			formatting = {
-- 				fields = { "kind", "abbr", "menu" },
-- 				format = function(entry, vim_item)
-- 					vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
-- 					vim_item.menu = ({
-- 						nvim_lsp = "[LSP]",
-- 						luasnip = "[Snippet]",
-- 						buffer = "[Buffer]",
-- 						path = "[Path]",
-- 					})[entry.source.name]
-- 					return vim_item
-- 				end,
-- 			},
-- 		})
-- 	end,
-- }

return {
	"saghen/blink.cmp",
	event = "VeryLazy",
	dependencies = "rafamadriz/friendly-snippets",
	version = "v0.*",
	opts = {
		keymap = {
			preset = "enter",
			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-p>"] = { "scroll_documentation_up", "fallback" },
			["<C-n>"] = { "scroll_documentation_down", "fallback" },
		},
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},
		sources = {
        -- add lazydev to your completion providers
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
        },
      }, 
		},
		signature = { enabled = true },
		completion = {
      
			menu = {
        auto_show = function (ctx)
          return ctx.mode ~= "cmdline"
        end,
				border = "rounded",
				draw = {
					columns = { { "label", "label_description", gap = 1 }, { "kind" } },
				},
			},
		},
	},
}
