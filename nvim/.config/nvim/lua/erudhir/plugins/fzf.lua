return {
	"ibhagwan/fzf-lua",
	enabled = false,
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local status, fzf = pcall(require, "fzf-lua")
		if not status then
			return
		end

		fzf.setup({})

		--keymaps from ui
		fzf.config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
		fzf.config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"

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

		keymap.set("n", ";T", function()
			fzf.grep({ search = "TODO|HACK|NOTE|FIX", no_esc = true })
		end, { desc = "Find all TODOs,HACKs,NOTEs and FIXs" })

		keymap.set("n", ";h", function()
			fzf.help_tags()
		end, { desc = "Find tags in files" })

		keymap.set("n", ";d", function()
			fzf.diagnostics_document()
		end, { desc = "Find all diagnostics" })

		keymap.set("n", ";D", function()
			fzf.diagnostics_workspace()
		end, { desc = "Find all diagnostics in workspace" })

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
