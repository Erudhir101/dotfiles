return {
  "epwalsh/obsidian.nvim",
  enable = false,
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    ui = { enable = false },
    workspaces = {
      {
        name = "personal",
        path = "/mnt/backup/Documents/study/erudhirVault",
        -- path = "/media/erudhir/Documents/study/erudhirVault/",
      },
    },
  },
}
