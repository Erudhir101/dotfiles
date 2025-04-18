local key = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
key.set("i", "jk", "<esc>", { desc = "exit insert mode with jk", noremap = false })

key.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
key.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- delete single character without copying into register
key.set("n", "x", '"_x', { desc = "delete without copy to buffer" })

-- put lines together with 'J'
key.set("n", "J", "mzJ`z", { desc = "put lines together" })

-- cursor in the middle with move files
key.set("n", "<C-d>", "<C-d>zz", { desc = "move code to down but the view in the center " })
key.set("n", "<C-u>", "<C-u>zz", { desc = "move cod to up but the view in the center" })
key.set("n", "n", "nzzzv", { desc = "move the selection code down but in the center" })
key.set("n", "N", "Nzzzv", { desc = "move the selection code up but in the center" })

-- clear search highlights
key.set({ "i", "n" }, "<leader>.", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- select all
key.set("n", "<C-a>", "gg<S-v>G", { desc = "select all text" })

-- increment/decrement numbers
key.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
key.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

key.set("n", "<Tab>", "<cmd>tabnext<CR>", { desc = "Go to next tab" }) --  go to next tab
key.set("n", "<S-Tab>", "<cmd>tabprevious<CR>", { desc = "Go to previous tab" }) --  go to next tab
