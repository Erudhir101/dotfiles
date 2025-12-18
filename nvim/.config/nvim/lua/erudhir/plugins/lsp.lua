return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      servers = {
        clangd = {},
        cssls = {},
        html = { filetypes = { "html", "twig", "hbs" } },
        jsonls = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              runtime = { version = "LuaJIT" },
              workspace = {
                checkThirdParty = false,
                library = {
                  "${3rd}/luv/library",
                  unpack(vim.api.nvim_get_runtime_file("", true)),
                },
              },
              diagnostics = { disable = { "missing-fields" } },
              format = {
                enable = false,
              },
            },
          },
        },
        svelte = {},
        tailwindcss = {},
        ts_ls = {},
        zls = {},
      },
    },
    config = function(_, opts)
      require("mason").setup()
      require("mason-lspconfig").setup({
        automatic_enable = false,
        ensure_installed = { "lua_ls", "ts_ls", "tailwindcss", "svelte" },
      })

      vim.diagnostic.config({
        underline = true,
        virtual_text = true,
      })

      for server, config in pairs(opts.servers) do
        vim.lsp.config(server, require("blink.cmp").get_lsp_capabilities(config.capabilities))
        vim.lsp.enable(server)
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc" -- enable completion trigerred

          -- Buffer local mappings.
          -- See ":help vim.lsp.*" for documentation
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
          end

          local picker = require("snacks.picker")

          map("<leader>ld", function()
            picker.lsp_definitions()
          end, "Definition")
          map("<leader>lr", function()
            picker.lsp_references()
          end, "References")
          map("<leader>li", function()
            picker.lsp_implementations()
          end, "Implementation")
          map("<leader>ls", function()
            picker.lsp_workspace_symbols()
          end, "Document Symbols")
          map("<leader>lr", vim.lsp.buf.rename, "Rename")
          map("K", vim.lsp.buf.hover, "show information in hover")
          map("<leader>la", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
        end,
      })
    end,
  },
}
