return {
	{ "nvim-lua/plenary.nvim" },
	-- { "MunifTanjim/nui.nvim" },
	{ "christoomey/vim-tmux-navigator" },
	-- {
	-- 	"jsongerber/nvim-px-to-rem",
	-- 	event = "CmdlineLeave",
	-- 	config = function()
	-- 		local status, pxToRem = pcall(require, "nvim-px-to-rem")
	-- 		if not status then
	-- 			return
	-- 		end
	-- 		pxToRem.setup()
	-- 	end,
	-- },
	{
		"nvim-zh/better-escape.vim",
		event = { "InsertEnter" },
	},
}
