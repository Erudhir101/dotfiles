return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			servers = {
				ts_ls = {},
				html = { filetypes = { "html", "twig", "hbs" } },
				cssls = {},
				tailwindcss = {},
				jsonls = {},
				svelte = {},

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
				vim.lsp.config(server, config)
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

					map("gd", function()
						picker.lsp_definitions()
					end, "[G]oto [D]efinition")
					map("gr", function()
						picker.lsp_references()
					end, "[G]oto [R]eferences")
					map("gi", function()
						picker.lsp_implementations()
					end, "[G]oto [I]mplementation")
					map("ds", function()
						picker.lsp_workspace_symbols()
					end, "[D]ocument [S]ymbols")
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("K", vim.lsp.buf.hover, "show information in hover")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
				end,
			})
		end,
	},
}
