return {
	"brenoprata10/nvim-highlight-colors",
	enabled = false,
	event = "VeryLazy",
	config = function()
		local status, highlight = pcall(require, "nvim-highlight-colors")
		if not status then
			return
		end
		highlight.setup({
			render = "virtual",
			enable_tailwind = true,
		})
	end,
}
