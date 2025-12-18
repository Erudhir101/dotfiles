-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- tree setting in explore
vim.cmd("let g:netrw_liststyle = 3")

-- markdown config
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "*" },
  callback = function()
    if vim.bo.filetype == "markdown" then
      vim.opt.spell = true
      vim.opt.wrap = true
    end
  end,
})

-- Don"t auto commenting new lines
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("no_auto_command", {}),
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- spell in some files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

---open help in vertical
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  command = "wincmd L",
})

---auto resized when windows resize
vim.api.nvim_create_autocmd("VimResized", {
  command = "wincmd =",
})

-- vim.api.nvim_create_autocmd("LspProgress", {
-- 	---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
-- 	callback = function(ev)
-- 		local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
-- 		vim.notify(vim.lsp.status(), "info", {
-- 			id = "lsp_progress",
-- 			title = "LSP Progress",
-- 			opts = function(notif)
-- 				notif.icon = ev.data.params.value.kind == "end" and " "
-- 					or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
-- 			end,
-- 		})
-- 	end,
-- })
