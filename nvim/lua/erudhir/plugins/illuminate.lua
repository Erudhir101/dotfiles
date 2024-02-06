return {
	"RRethy/vim-illuminate", -- iluminate selected term
	event = "BufReadPost",
	config = function()
		local status, illu = pcall(require, "illuminate")
		if not status then
			return
		end
	end,
}
