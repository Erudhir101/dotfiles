return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local status, harpoon = pcall(require, "harpoon")
		if not status then
			return
		end

		harpoon.setup({ settings = {
			save_on_toggle = true,
		} })

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end, { desc = "add file to harpoon" })
		vim.keymap.set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "toggle harpoon" })

		-- make keybinding for change with all numbers base on position
		for i = 1, 9 do
			vim.keymap.set("n", string.format("<M-%d>", i), function()
				harpoon:list():select(i)
			end, { desc = string.format("select the %d file", i) })
		end
		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<S-Tab>", function()
			harpoon:list():prev()
		end, { desc = "go to the prev in the list" })

		vim.keymap.set("n", "<Tab>", function()
			harpoon:list():next()
		end, { desc = "go to the next in the list" })
	end,
}
