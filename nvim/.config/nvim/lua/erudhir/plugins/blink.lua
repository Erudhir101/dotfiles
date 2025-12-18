local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
return {
  "saghen/blink.cmp",
  event = "VeryLazy",
  dependencies = { { "nvim-mini/mini.icons", version = false }, { "L3MON4D3/LuaSnip", version = "v2.*" } },
  version = "1.*",
  opts = {
    keymap = { preset = "default", ["<C-y>"] = { "accept", "fallback" } },
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
            { "kind_icon", "kind",              gap = 1 },
            { "label",     "label_description", gap = 1 },
          },
          components = {
            kind_icon = {
              text = function(ctx)
                local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                return kind_icon
              end,
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
            kind = {
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
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
