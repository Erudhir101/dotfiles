-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- delete single character without copying into register
keymap.set("n", "x", '"_x', { desc = "delete without copy to buffer" })
-- keymap.set("n", "<Leader>p", '"0p', { desc = "paste" })
-- keymap.set("n", "<Leader>P", '"0P', { desc = "paste" })
-- keymap.set("v", "<Leader>p", '"0p', { desc = "paste" })
-- keymap.set("n", "<Leader>c", '"_c', { desc = "change" })
-- keymap.set("n", "<Leader>C", '"_C', { desc = "change" })
-- keymap.set("v", "<Leader>c", '"_c', { desc = "change" })
-- keymap.set("v", "<Leader>C", '"_C', { desc = "change" })
-- keymap.set("n", "<Leader>d", '"_d', { desc = "delete without copy to buffer" })
-- keymap.set("n", "<Leader>D", '"_D', { desc = "delete without copy to buffer" })
-- keymap.set("v", "<Leader>d", '"_d', { desc = "delete without copy to buffer" })
-- keymap.set("v", "<Leader>D", '"_D', { desc = "delete without copy to buffer" })

-- keymap.set("n", "<leader>e", ":Explore<CR>", { desc = "toogle explore" })

keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move block of code to up" })
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move block of code to down" })

keymap.set("n", "J", "mzJ`z", { desc = "put lines together" })
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move code to down but the view in the center " })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move cod to up but the view in the center" })
keymap.set("n", "n", "nzzzv", { desc = "move the selection code down but in the center" })
keymap.set("n", "N", "Nzzzv", { desc = "move the selection code up but in the center" })

-- keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "rename the register" })

-- clear search highlights
keymap.set("n", "<leader>.", ":nohl<CR>", { desc = "Clear search highlights" })

-- select all
keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "select all text" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>te", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab

keymap.set("n", "<Tab>", "<cmd>tabnext<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<S-Tab>", "<cmd>tabprevious<CR>", { desc = "Go to previous tab" }) --  go to next tab
