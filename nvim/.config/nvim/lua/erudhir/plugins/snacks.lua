return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	config = function()
		local status, snacks = pcall(require, "snacks")
		if not status then
			return
		end

		snacks.setup({
			bigfile = { enabled = true, notify = true, size = 100 * 1024 },
			dashboard = {
				enabled = true,
				preset = {
					keys = {
						{
							icon = " ",
							key = "f",
							desc = "Find File",
							action = ":lua FzfLua.files()",
						},
						{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
						{
							icon = " ",
							key = "g",
							desc = "Find Text",
							action = ":lua FzfLua.live_grep()",
						},
						{
							icon = " ",
							key = "r",
							desc = "Recent Files",
							action = ":lua FzfLua.oldfiles()",
						},
						{
							icon = " ",
							key = "c",
							desc = "Config",
							action = ":lua FzfLua.files({cwd = vim.fn.stdpath('config')})",
						},
						{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
						{
							icon = "󰒲 ",
							key = "l",
							desc = "Lazy",
							action = ":Lazy",
							enabled = package.loaded.lazy ~= nil,
						},
						{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
					},
				},
			},
			indent = { enabled = true, animate = { enabled = false } },
			input = { enabled = false },
			picker = { enabled = true, replace_netrw = true },
			quickfile = { enabled = false },
			scroll = { enabled = false },
			statuscolumn = { enabled = false },
			words = { enabled = false },
			lazygit = { enabled = true },
		})

		vim.keymap.set("n", "<leader>lg", function()
			snacks.lazygit()
		end, { desc = "Lazygit open" })

		vim.keymap.set("n", "<C-e>", function()
			snacks.explorer()
		end, { desc = "Open Explorer" })

		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesActionRename",
			callback = function(event)
				Snacks.rename.on_rename_file(event.data.from, event.data.to)
			end,
		})
	end,
}
