local opt          = vim.o -- for conciseness

-- encoding
vim.scriptencoding = "utf-8"
opt.encoding       = "utf-8"
opt.fileencoding   = "utf-8"

opt.mouse          = 'a'
opt.undofile       = true
vim.o.shada        = "'100,<50,s10,:1000,/100,@100,h"

-- update
opt.updatetime     = 50

-- line numbers
opt.relativenumber = true
opt.number         = true
opt.ruler          = false

-- tabs & indentation
opt.tabstop        = 2
opt.softtabstop    = 2
opt.shiftwidth     = 2
opt.expandtab      = true
opt.autoindent     = true
opt.smartindent    = true
opt.linebreak      = true
opt.formatoptions  = "rqnl1j"

-- line wrapping
opt.wrap           = false

-- search settings
opt.ignorecase     = true
opt.smartcase      = true

-- cursor line
opt.cursorline     = true
opt.cursorlineopt  = "screenline,number"
-- opt.guicursor = ""

-- search
opt.hlsearch       = true
opt.incsearch      = true

-- scroll
opt.scrolloff      = 8

-- appearance
opt.breakindent    = true
opt.breakindentopt = 'list:-1'
opt.colorcolumn    = '+1'

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors  = true
opt.background     = "dark"
opt.signcolumn     = "yes"
opt.conceallevel   = 1

-- backspace
opt.backspace      = "indent,eol,start"

-- clipboard
opt.clipboard      = "unnamedplus"

-- split windows
opt.splitright     = true
opt.splitbelow     = true
opt.splitkeep      = 'screen'
opt.winborder      = 'single'

-- turn off swapfile
opt.swapfile       = false

-- spell check
opt.spelllang      = "pt_br,en_us"
opt.spell          = false

opt.shortmess      = "CFOSWaco"
opt.showmode       = false
