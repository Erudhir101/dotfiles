return {
	"nvim-tree/nvim-web-devicons",
	-- lazy = true,
	config = function()
		local status, devicons = pcall(require, "nvim-web-devicons")
		if not status then
			return
		end
		devicons.set_icon({})
	end,
}
