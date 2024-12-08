-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- tree setting in explore
vim.cmd("let g:netrw_liststyle = 3")

-- markdown config
vim.api.nvim_create_autocmd({ "filetype" }, {
	pattern = { "*" },
	callback = function()
		if vim.bo.filetype == "markdown" then
			vim.opt.spell = true
			vim.opt.wrap = true
		end
	end,
})

-- Don"t auto commenting new lines
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "",
	command = "set fo-=c fo-=r fo-=o",
})

-- spell in some files
vim.api.nvim_create_autocmd("Filetype", {
	pattern = { "gitcommit", "markdown", "text" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})
