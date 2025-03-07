return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local status, which = pcall(require, "which-key")
		if not status then
			return
		end

		which.setup({
			preset = "helix",
		})
	end,
}
