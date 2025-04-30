return {
	-- Main LSP Configuration
	"neovim/nvim-lspconfig",
	event = { "BufRead", "BufNewFile" },
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for Neovim
		{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		-- Allows extra capabilities provided by nvim-cmp
		-- "hrsh7th/cmp-nvim-lsp",
		"saghen/blink.cmp",
		{ "j-hui/fidget.nvim", opts = {} },
	},

	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "rounded",
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				local fzf = require("fzf-lua")

				map("gd", function()
					fzf.lsp_definitions({ ignore_current_line = true })
				end, "[G]oto [D]efinition")
				map("gr", function()
					fzf.lsp_references({ ignore_current_line = true })
				end, "[G]oto [R]eferences")
				map("gi", function()
					fzf.lsp_implementations({ ignore_current_line = true })
				end, "[G]oto [I]mplementation")
				map("ds", function()
					fzf.lsp_workspace_symbols({ ignore_current_line = true })
				end, "[D]ocument [S]ymbols")
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("K", vim.lsp.buf.hover, "show information in hover")
				map("[d", vim.diagnostic.goto_prev, "show previest diagnostic")
				map("]d", vim.diagnostic.goto_next, "show next diagnostic")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				-- if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
				-- 	map("<leader>th", function()
				-- 		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
				-- 	end, "[T]oggle Inlay [H]ints")
				-- end
			end,
		})

		local servers = {
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
		}

		require("mason").setup()

		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"bashls",
			"cssls",
			"eslint_d",
			"html",
			"jsonls",
			"lua_ls",
			"prettier",
			"prettierd",
			"shfmt",
			"stylua",
			"svelte",
			"tailwindcss",
			"ts_ls",
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
