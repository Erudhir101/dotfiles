local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
return {
	"saghen/blink.cmp",
	event = "VeryLazy",
	dependencies = { { "rafamadriz/friendly-snippets" }, { "echasnovski/mini.icons", version = false } },
	version = "*",
	opts = {
		keymap = { preset = "default", ["<C-i>"] = { "accept", "fallback" } },
		appearance = {
			nerd_font_variant = "mono",
		},
		completion = {
			keyword = { range = "full" },
			menu = {
				auto_show = true,
				border = border,
				draw = {
					columns = {
						{ "kind_icon", "kind", gap = 1 },
						{ "label", "label_description", gap = 1 },
					},
					components = {
						kind_icon = {
							ellipsis = false,
							text = function(ctx)
								local miniIcons = require("mini.icons")
								if ctx.kind == "Folder" then
									return miniIcons.get("directory", ctx.label)
								end
								if ctx.kind == "File" then
									return miniIcons.get("file", ctx.label)
								end
								if ctx.kind == "Copilot" then
									return ""
								end
								local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
								return kind_icon
							end,
							-- Optionally, you may also use the highlights from mini.icons
							highlight = function(ctx)
								if ctx.kind == "Folder" then
									local _, hl, _ = require("mini.icons").get("directory", ctx.label)
									return hl
								end
								if ctx.kind == "File" then
									local _, hl, _ = require("mini.icons").get("file", ctx.label)
									return hl
								end
								if ctx.kind == "Copilot" then
									local _, hl, _ = require("mini.icons").get("os", "nixos")
									return hl
								end
								local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
								return hl
							end,
						},
						kind = {
							text = function(ctx)
								return " " .. ctx.kind
							end,
						},
					},
				},
			},
			documentation = {
				window = {
					border = border,
				},
				auto_show = true,
				auto_show_delay_ms = 500,
			},
			trigger = {
				show_on_keyword = true,
			},
		},
		sources = {
			default = { "lazydev", "lsp", "path", "snippets", "buffer" },
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
			},
		},
	},
}
