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
			image = { enabled = true },
			indent = { enabled = true, animate = { enabled = false } },
			lazygit = { enabled = true },
			input = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = false },
			scroll = { enabled = false },
			statuscolumn = { enabled = false },
			words = { enabled = false },
			dashboard = {
				enabled = true,
				preset = {
					keys = {
						{
							icon = " ",
							key = "f",
							desc = "Find File",
							action = ":lua Snacks.dashboard.pick('files')",
						},
						{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
						{
							icon = " ",
							key = "g",
							desc = "Find Text",
							action = ":lua Snacks.dashboard.pick('live_grep')",
						},
						{
							icon = " ",
							key = "r",
							desc = "Recent Files",
							action = ":lua Snacks.dashboard.pick('oldfiles')",
						},
						{
							icon = " ",
							key = "c",
							desc = "Config",
							action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
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
			picker = {
				enabled = true,
				excludes = { ".git", "node_modules" },
				auto_close = true,
				sources = {},
			},
		})

		vim.keymap.set("n", "<leader>lg", function()
			snacks.lazygit()
		end, { desc = "Lazygit open" })

		vim.keymap.set("n", "<C-e>", function()
			snacks.explorer()
		end, { desc = "Open Explorer" })

		vim.keymap.set("n", ";f", function()
			snacks.picker.files({ hidden = true })
		end, { desc = "Fuzzy find files in cwd" })

		vim.keymap.set("n", ";g", function()
			snacks.picker.grep({ hidden = true })
		end, { desc = "Find string in cwd" })

		vim.keymap.set("n", ";m", function()
			snacks.picker.marks()
		end, { desc = "Find marks in files" })

		vim.keymap.set("n", ";T", function()
			snacks.picker.grep({ search = "TODO|HACK|NOTE|FIX", hidden = true })
		end, { desc = "Find all TODOs,HACKs,NOTEs and FIXs" })

		vim.keymap.set("n", ";h", function()
			snacks.picker.help()
		end, { desc = "Find tags in files" })

		vim.keymap.set("n", ";d", function()
			snacks.picker.diagnostics()
		end, { desc = "Find all diagnostics" })

		vim.keymap.set("n", ";D", function()
			snacks.picker.diagnostics_buffer()
		end, { desc = "Find all diagnostics in workspace" })

		vim.keymap.set("n", ";b", function()
			snacks.picker.buffers()
		end, { desc = "Find all buffers" })

		vim.keymap.set("n", ";k", function()
			snacks.picker.keymaps()
		end, { desc = "Find vim.keymaps" })

		vim.keymap.set("n", "<leader>si", function()
			snacks.picker.icons()
		end, { desc = "Find Icons emoji" })

		vim.keymap.set("n", ";z", function()
			snacks.picker.spelling()
		end, { desc = "show spell words suggestions" })

		vim.keymap.set("n", "<leader>uC", function()
			snacks.picker.colorschemes()
		end, { desc = "chose coloscheme" })

		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesActionRename",
			callback = function(event)
				Snacks.rename.on_rename_file(event.data.from, event.data.to)
			end,
		})
	end,

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
	-- }),
}
