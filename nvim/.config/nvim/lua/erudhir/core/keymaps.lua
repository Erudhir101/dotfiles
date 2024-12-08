local key = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
key.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- delete single character without copying into register
key.set("n", "x", '"_x', { desc = "delete without copy to buffer" })

key.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move block of code to up" })
key.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move block of code to down" })

key.set("n", "J", "mzJ`z", { desc = "put lines together" })
key.set("n", "<C-d>", "<C-d>zz", { desc = "move code to down but the view in the center " })
key.set("n", "<C-u>", "<C-u>zz", { desc = "move cod to up but the view in the center" })
key.set("n", "n", "nzzzv", { desc = "move the selection code down but in the center" })
key.set("n", "N", "Nzzzv", { desc = "move the selection code up but in the center" })

-- key.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "rename the register" })

-- clear search highlights
key.set("n", "<leader>.", ":nohl<CR>", { desc = "Clear search highlights" })

-- select all
key.set("n", "<C-a>", "gg<S-v>G", { desc = "select all text" })

-- increment/decrement numbers
key.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
key.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
key.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
key.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
key.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
key.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

key.set("n", "<leader>te", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
key.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab

key.set("n", "<Tab>", "<cmd>tabnext<CR>", { desc = "Go to next tab" }) --  go to next tab
key.set("n", "<S-Tab>", "<cmd>tabprevious<CR>", { desc = "Go to previous tab" }) --  go to next tab
