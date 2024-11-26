return {
	"ibhagwan/fzf-lua",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local status, fzf = pcall(require, "fzf-lua")
		if not status then
			return
		end

		fzf.setup({})

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", ";f", function()
			fzf.files()
		end, { desc = "Fuzzy find files in cwd" })

		keymap.set("n", ";g", function()
			fzf.live_grep()
		end, { desc = "Find string in cwd" })

		keymap.set("n", ";t", function()
			fzf.tags()
		end, { desc = "Find tags in files" })

		keymap.set("n", ";h", function()
			fzf.help_tags()
		end, { desc = "Find tags in files" })

		keymap.set("n", ";d", function()
			fzf.diagnostics_document()
		end, { desc = "Find all diagnostics" })

		keymap.set("n", ";b", function()
			fzf.buffers()
		end, { desc = "Find all buffers" })

		keymap.set("n", ";k", function()
			fzf.keymaps()
		end, { desc = "Find keymaps" })

		keymap.set("n", ";z", function()
			fzf.spell_suggest()
		end, { desc = "show spell words suggestions" })
	end,
}
