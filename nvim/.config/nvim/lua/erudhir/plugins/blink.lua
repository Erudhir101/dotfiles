return {
	"saghen/blink.cmp",
	event = "VeryLazy",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "v0.*",
	opts = {
		keymap = {
			preset = "default",
			["<C-i>"] = { "accept", "fallback" },
		},
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
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
		signature = { enabled = true },
		completion = {
			menu = {
				auto_show = true,
				border = "rounded",
				draw = {
					columns = { { "label", "label_description", gap = 1 }, { "kind" } },
				},
			},
		},
	},
}
