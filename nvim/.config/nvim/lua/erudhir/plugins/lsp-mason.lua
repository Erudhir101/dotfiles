return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local status, mason = pcall(require, "mason")
		if not status then
			return
		end

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		-- import null
		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			PATH = "prepend", -- "skip" seems to cause the spawning error
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"cssls",
				"emmet_ls",
				"html",
				"lua_ls",
				-- "prismals",
				-- "pyright",
				"svelte",
				"tailwindcss",
				"tsserver",
				"gopls",
			},
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true, -- not the same as ensure_installed
		})
		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- js formatter
				"stylua", -- lua formatter
				-- "black", -- python formatter
				-- "pylint", -- python linter
				-- "eslint_d", -- js linter
				"biome", -- js linter and formatter
			},
		})
	end,
}
