return {
	"numToStr/Comment.nvim",
	event = "VeryLazy",
	-- event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		-- import comment plugin safely
		local status, comment = pcall(require, "Comment")
		if not status then
			return
		end

		local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

		-- enable comment
		comment.setup({
			mappings = {
				extra = false,
			},
			-- for commenting tsx and jsx files
			pre_hook = ts_context_commentstring.create_pre_hook(),
		})
	end,
}
