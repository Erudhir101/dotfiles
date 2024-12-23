return {
	"mfussenegger/nvim-lint",
	-- lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
	config = function()
		local status, lint = pcall(require, "lint")
		if not status then
			return
		end

		local eslint = { "eslint_d" }

		lint.linters_by_ft = {
			javascript = eslint,
			typescript = eslint,
			javascriptreact = eslint,
			typescriptreact = eslint,
			svelte = eslint,
			python = { "pylint" },
			-- rust = { "ast_grep" },
			-- c = { "ast_grep" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>lt", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
