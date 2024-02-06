return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	event = "VeryLazy",
	config = function()
		-- local keymap = vim.keymap
		-- keymap.set("n", "<leader>m", "<cmd>TSToolsOrganizeImports<cr>")
		-- keymap.set("n", "<leader>a", "<cmd>TSToolsAddMissingImports<cr>")

		local status, api = pcall(require, "typescript-tools.api")
		if not status then
			return
		end
		require("typescript-tools").setup({
			handlers = {
				["textDocument/publishDiagnostics"] = api.filter_diagnostics({ 6133 }),
			},
			settings = {
				tsserver_file_preferences = {
					importModuleSpecifierPreference = "non-relative",
				},
				tsserver_plugins = {
					"@styled/tyepscript-styled-plugin",
					-- for old version of typescript
					-- "typescript-styled-plugin"
				},
			},
		})
	end,
}
