return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local status, conform = pcall(require, "conform")
		if not status then
			return
		end
		local prettier = {
			"prettierd",
			"prettier",
			stop_after_first = true,
		}
		conform.setup({
			formatters_by_ft = {
				javascript = prettier,
				typescript = prettier,
				javascriptreact = prettier,
				typescriptreact = prettier,
				svelte = prettier,
				css = prettier,
				html = prettier,
				json = prettier,
				jsonc = prettier,
				yaml = prettier,
				markdown = prettier,
				graphql = prettier,
				lua = { "stylua" },
				c = { "clang-format" },
				-- rust = { "ast_grep" },
				python = { "isort", "black" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
			formatters = {
				astyle = {
					command = "astyle",
					prepend_args = { "-s2", "-c", "-J", "-n", "-q", "-z2", "-xC80" },
				},
				["clang-format"] = {
					command = "clang-format",
					prepend_args = { "--style=file", "-i" },
				},
				["cmake-format"] = {
					command = "cmake-format",
					prepend_args = { "-i" },
				},
				prettier = {
					command = "prettier",
					prepend_args = { "-w" },
				},
				prettierd = {
					command = "prettierd",
					prepend_args = { "-w" },
				},
			},
		})
		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
