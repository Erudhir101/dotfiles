let s:cpo_save=&cpo
set cpo&vim
inoremap <C-W> u
inoremap <C-U> u
nnoremap  ggVG
nnoremap  zz
nnoremap <silent>  :TmuxNavigateLeft
nnoremap 	 <Cmd>tabnext
nnoremap <silent> <NL> :TmuxNavigateDown
nnoremap <silent>  :TmuxNavigateUp
nnoremap <silent>  :TmuxNavigateRight
nnoremap <silent>  <Cmd>lua MiniBracketed.register_undo_state()
nnoremap  zz
nmap  d
nnoremap <silent>  :TmuxNavigatePrevious
nnoremap  tx <Cmd>tabclose
nnoremap  te <Cmd>tabnew
nnoremap  sx <Cmd>close
nnoremap  se =
nnoremap  sh s
nnoremap  sv v
nnoremap  - 
nnoremap  + 
nnoremap  . :nohl
vnoremap  D "_D
vnoremap  d "_d
nnoremap  D "_D
nnoremap  d "_d
vnoremap  C "_C
vnoremap  c "_c
nnoremap  C "_C
nnoremap  c "_c
vnoremap  p "0p
nnoremap  P "0P
nnoremap  p "0p
omap <silent> % <Plug>(MatchitOperationForward)
xmap <silent> % <Plug>(MatchitVisualForward)
nmap <silent> % <Plug>(MatchitNormalForward)
nnoremap & :&&
xnoremap <silent> <expr> @ mode() ==# 'V' ? ':normal! @'.getcharstr().'' : '@'
nnoremap J mzJ`z
vnoremap J :m '>+1gv=gv
vnoremap K :m '<-2gv=gv
nnoremap N Nzzzv
xnoremap <silent> <expr> Q mode() ==# 'V' ? ':normal! @=reg_recorded()' : 'Q'
nnoremap Y y$
omap <silent> [% <Plug>(MatchitOperationMultiBackward)
xmap <silent> [% <Plug>(MatchitVisualMultiBackward)
nmap <silent> [% <Plug>(MatchitNormalMultiBackward)
nnoremap <silent> [y <Cmd>lua MiniBracketed.yank('backward')
nnoremap <silent> [Y <Cmd>lua MiniBracketed.yank('first')
nnoremap <silent> [w <Cmd>lua MiniBracketed.window('backward')
nnoremap <silent> [W <Cmd>lua MiniBracketed.window('first')
nnoremap <silent> [u <Cmd>lua MiniBracketed.undo('backward')
nnoremap <silent> [U <Cmd>lua MiniBracketed.undo('first')
onoremap <silent> [t v<Cmd>lua MiniBracketed.treesitter('backward')
xnoremap <silent> [t <Cmd>lua MiniBracketed.treesitter('backward')
nnoremap <silent> [t <Cmd>lua MiniBracketed.treesitter('backward')
onoremap <silent> [T v<Cmd>lua MiniBracketed.treesitter('first')
xnoremap <silent> [T <Cmd>lua MiniBracketed.treesitter('first')
nnoremap <silent> [T <Cmd>lua MiniBracketed.treesitter('first')
nnoremap <silent> [q <Cmd>lua MiniBracketed.quickfix('backward')
nnoremap <silent> [Q <Cmd>lua MiniBracketed.quickfix('first')
nnoremap <silent> [l <Cmd>lua MiniBracketed.location('backward')
nnoremap <silent> [L <Cmd>lua MiniBracketed.location('first')
nnoremap <silent> [o <Cmd>lua MiniBracketed.oldfile('backward')
nnoremap <silent> [O <Cmd>lua MiniBracketed.oldfile('first')
onoremap <silent> [j v<Cmd>lua MiniBracketed.jump('backward')
nnoremap <silent> [j <Cmd>lua MiniBracketed.jump('backward')
onoremap <silent> [J v<Cmd>lua MiniBracketed.jump('first')
nnoremap <silent> [J <Cmd>lua MiniBracketed.jump('first')
onoremap <silent> [i V<Cmd>lua MiniBracketed.indent('backward')
xnoremap <silent> [i <Cmd>lua MiniBracketed.indent('backward')
nnoremap <silent> [i <Cmd>lua MiniBracketed.indent('backward')
onoremap <silent> [I V<Cmd>lua MiniBracketed.indent('first')
xnoremap <silent> [I <Cmd>lua MiniBracketed.indent('first')
nnoremap <silent> [I <Cmd>lua MiniBracketed.indent('first')
nnoremap <silent> [f <Cmd>lua MiniBracketed.file('backward')
nnoremap <silent> [F <Cmd>lua MiniBracketed.file('first')
onoremap <silent> [d v<Cmd>lua MiniBracketed.diagnostic('backward')
xnoremap <silent> [d <Cmd>lua MiniBracketed.diagnostic('backward')
onoremap <silent> [D v<Cmd>lua MiniBracketed.diagnostic('first')
xnoremap <silent> [D <Cmd>lua MiniBracketed.diagnostic('first')
nnoremap <silent> [D <Cmd>lua MiniBracketed.diagnostic('first')
onoremap <silent> [x V<Cmd>lua MiniBracketed.conflict('backward')
xnoremap <silent> [x <Cmd>lua MiniBracketed.conflict('backward')
nnoremap <silent> [x <Cmd>lua MiniBracketed.conflict('backward')
onoremap <silent> [X V<Cmd>lua MiniBracketed.conflict('first')
xnoremap <silent> [X <Cmd>lua MiniBracketed.conflict('first')
nnoremap <silent> [X <Cmd>lua MiniBracketed.conflict('first')
onoremap <silent> [c V<Cmd>lua MiniBracketed.comment('backward')
xnoremap <silent> [c <Cmd>lua MiniBracketed.comment('backward')
nnoremap <silent> [c <Cmd>lua MiniBracketed.comment('backward')
onoremap <silent> [C V<Cmd>lua MiniBracketed.comment('first')
xnoremap <silent> [C <Cmd>lua MiniBracketed.comment('first')
nnoremap <silent> [C <Cmd>lua MiniBracketed.comment('first')
nnoremap <silent> [b <Cmd>lua MiniBracketed.buffer('backward')
nnoremap <silent> [B <Cmd>lua MiniBracketed.buffer('first')
nnoremap <silent> [d <Cmd>lua MiniBracketed.diagnostic('backward')
omap <silent> ]% <Plug>(MatchitOperationMultiForward)
xmap <silent> ]% <Plug>(MatchitVisualMultiForward)
nmap <silent> ]% <Plug>(MatchitNormalMultiForward)
nnoremap <silent> ]y <Cmd>lua MiniBracketed.yank('forward')
nnoremap <silent> ]Y <Cmd>lua MiniBracketed.yank('last')
nnoremap <silent> ]w <Cmd>lua MiniBracketed.window('forward')
nnoremap <silent> ]W <Cmd>lua MiniBracketed.window('last')
nnoremap <silent> ]u <Cmd>lua MiniBracketed.undo('forward')
nnoremap <silent> ]U <Cmd>lua MiniBracketed.undo('last')
onoremap <silent> ]t v<Cmd>lua MiniBracketed.treesitter('forward')
xnoremap <silent> ]t <Cmd>lua MiniBracketed.treesitter('forward')
nnoremap <silent> ]t <Cmd>lua MiniBracketed.treesitter('forward')
onoremap <silent> ]T v<Cmd>lua MiniBracketed.treesitter('last')
xnoremap <silent> ]T <Cmd>lua MiniBracketed.treesitter('last')
nnoremap <silent> ]T <Cmd>lua MiniBracketed.treesitter('last')
nnoremap <silent> ]q <Cmd>lua MiniBracketed.quickfix('forward')
nnoremap <silent> ]Q <Cmd>lua MiniBracketed.quickfix('last')
nnoremap <silent> ]l <Cmd>lua MiniBracketed.location('forward')
nnoremap <silent> ]L <Cmd>lua MiniBracketed.location('last')
nnoremap <silent> ]o <Cmd>lua MiniBracketed.oldfile('forward')
nnoremap <silent> ]O <Cmd>lua MiniBracketed.oldfile('last')
onoremap <silent> ]j v<Cmd>lua MiniBracketed.jump('forward')
nnoremap <silent> ]j <Cmd>lua MiniBracketed.jump('forward')
onoremap <silent> ]J v<Cmd>lua MiniBracketed.jump('last')
nnoremap <silent> ]J <Cmd>lua MiniBracketed.jump('last')
onoremap <silent> ]i V<Cmd>lua MiniBracketed.indent('forward')
xnoremap <silent> ]i <Cmd>lua MiniBracketed.indent('forward')
nnoremap <silent> ]i <Cmd>lua MiniBracketed.indent('forward')
onoremap <silent> ]I V<Cmd>lua MiniBracketed.indent('last')
xnoremap <silent> ]I <Cmd>lua MiniBracketed.indent('last')
nnoremap <silent> ]I <Cmd>lua MiniBracketed.indent('last')
nnoremap <silent> ]f <Cmd>lua MiniBracketed.file('forward')
nnoremap <silent> ]F <Cmd>lua MiniBracketed.file('last')
onoremap <silent> ]d v<Cmd>lua MiniBracketed.diagnostic('forward')
xnoremap <silent> ]d <Cmd>lua MiniBracketed.diagnostic('forward')
onoremap <silent> ]D v<Cmd>lua MiniBracketed.diagnostic('last')
xnoremap <silent> ]D <Cmd>lua MiniBracketed.diagnostic('last')
nnoremap <silent> ]D <Cmd>lua MiniBracketed.diagnostic('last')
onoremap <silent> ]x V<Cmd>lua MiniBracketed.conflict('forward')
xnoremap <silent> ]x <Cmd>lua MiniBracketed.conflict('forward')
nnoremap <silent> ]x <Cmd>lua MiniBracketed.conflict('forward')
onoremap <silent> ]X V<Cmd>lua MiniBracketed.conflict('last')
xnoremap <silent> ]X <Cmd>lua MiniBracketed.conflict('last')
nnoremap <silent> ]X <Cmd>lua MiniBracketed.conflict('last')
onoremap <silent> ]c V<Cmd>lua MiniBracketed.comment('forward')
xnoremap <silent> ]c <Cmd>lua MiniBracketed.comment('forward')
nnoremap <silent> ]c <Cmd>lua MiniBracketed.comment('forward')
onoremap <silent> ]C V<Cmd>lua MiniBracketed.comment('last')
xnoremap <silent> ]C <Cmd>lua MiniBracketed.comment('last')
nnoremap <silent> ]C <Cmd>lua MiniBracketed.comment('last')
nnoremap <silent> ]b <Cmd>lua MiniBracketed.buffer('forward')
nnoremap <silent> ]B <Cmd>lua MiniBracketed.buffer('last')
nnoremap <silent> ]d <Cmd>lua MiniBracketed.diagnostic('forward')
xmap a% <Plug>(MatchitVisualTextObject)
xnoremap gb <Plug>(comment_toggle_blockwise_visual)
nnoremap gb <Plug>(comment_toggle_blockwise)
omap <silent> g% <Plug>(MatchitOperationBackward)
xmap <silent> g% <Plug>(MatchitVisualBackward)
nmap <silent> g% <Plug>(MatchitNormalBackward)
xnoremap gc <Plug>(comment_toggle_linewise_visual)
nnoremap gc <Plug>(comment_toggle_linewise)
nnoremap n nzzzv
nnoremap <silent> u u<Cmd>lua MiniBracketed.register_undo_state()
nnoremap x "_x
xnoremap <Plug>(comment_toggle_blockwise_visual) <Cmd>lua require("Comment.api").locked("toggle.blockwise")(vim.fn.visualmode())
xnoremap <Plug>(comment_toggle_linewise_visual) <Cmd>lua require("Comment.api").locked("toggle.linewise")(vim.fn.visualmode())
xmap <silent> <Plug>(MatchitVisualTextObject) <Plug>(MatchitVisualMultiBackward)o<Plug>(MatchitVisualMultiForward)
onoremap <silent> <Plug>(MatchitOperationMultiForward) :call matchit#MultiMatch("W",  "o")
onoremap <silent> <Plug>(MatchitOperationMultiBackward) :call matchit#MultiMatch("bW", "o")
xnoremap <silent> <Plug>(MatchitVisualMultiForward) :call matchit#MultiMatch("W",  "n")m'gv``
xnoremap <silent> <Plug>(MatchitVisualMultiBackward) :call matchit#MultiMatch("bW", "n")m'gv``
nnoremap <silent> <Plug>(MatchitNormalMultiForward) :call matchit#MultiMatch("W",  "n")
nnoremap <silent> <Plug>(MatchitNormalMultiBackward) :call matchit#MultiMatch("bW", "n")
onoremap <silent> <Plug>(MatchitOperationBackward) :call matchit#Match_wrapper('',0,'o')
onoremap <silent> <Plug>(MatchitOperationForward) :call matchit#Match_wrapper('',1,'o')
xnoremap <silent> <Plug>(MatchitVisualBackward) :call matchit#Match_wrapper('',0,'v')m'gv``
xnoremap <silent> <Plug>(MatchitVisualForward) :call matchit#Match_wrapper('',1,'v'):if col("''") != col("$") | exe ":normal! m'" | endifgv``
nnoremap <silent> <Plug>(MatchitNormalBackward) :call matchit#Match_wrapper('',0,'n')
nnoremap <silent> <Plug>(MatchitNormalForward) :call matchit#Match_wrapper('',1,'n')
nnoremap <Plug>PlenaryTestFile :lua require('plenary.test_harness').test_file(vim.fn.expand("%:p"))
nnoremap <silent> <C-Bslash> :TmuxNavigatePrevious
nnoremap <silent> <C-K> :TmuxNavigateUp
nnoremap <silent> <C-J> :TmuxNavigateDown
nnoremap <silent> <C-H> :TmuxNavigateLeft
nnoremap <silent> <C-R> <Cmd>lua MiniBracketed.register_undo_state()
nnoremap <S-Tab> <Cmd>tabprevious
nnoremap <C-A> ggVG
nnoremap <C-U> zz
nnoremap <C-D> zz
nmap <C-W><C-D> d
nnoremap <silent> <C-L> :TmuxNavigateRight
inoremap  u
inoremap  u
inoremap jk 
let &cpo=s:cpo_save
unlet s:cpo_save
set clipboard=unnamedplus
set expandtab
set helplang=pt
set nohlsearch
set ignorecase
set noloadplugins
set packpath=/usr/share/nvim/runtime
set runtimepath=~/.config/nvim,~/.local/share/nvim/lazy/lazy.nvim,~/.local/share/nvim/lazy/dressing.nvim,~/.local/share/nvim/lazy/nvim-ts-autotag,~/.local/share/nvim/lazy/nvim-treesitter,~/.local/share/nvim/lazy/nvim-ts-context-commentstring,~/.local/share/nvim/lazy/Comment.nvim,~/.local/share/nvim/lazy/flash.nvim,~/.local/share/nvim/lazy/typescript-tools.nvim,~/.local/share/nvim/lazy/which-key.nvim,~/.local/share/nvim/lazy/bufferline.nvim,~/.local/share/nvim/lazy/neodev.nvim,~/.local/share/nvim/lazy/nvim-tree.lua,~/.local/share/nvim/lazy/plenary.nvim,~/.local/share/nvim/lazy/nvim-lsp-file-operations,~/.local/share/nvim/lazy/cmp-nvim-lsp,~/.local/share/nvim/lazy/nvim-lspconfig,~/.local/share/nvim/lazy/mason-tool-installer.nvim,~/.local/share/nvim/lazy/mason-lspconfig.nvim,~/.local/share/nvim/lazy/mason.nvim,~/.local/share/nvim/lazy/vim-tmux-navigator,~/.local/share/nvim/lazy/dashboard-nvim,~/.local/share/nvim/lazy/mini.hipatterns,~/.local/share/nvim/lazy/nvim-web-devicons,~/.local/share/nvim/lazy/fzf-lua,~/.local/share/nvim/lazy/mini.bracketed,~/.local/share/nvim/lazy/nvim,/usr/share/nvim/runtime,/usr/share/nvim/runtime/pack/dist/opt/matchit,/usr/lib64/nvim,~/.local/state/nvim/lazy/readme,~/.local/share/nvim/lazy/cmp-nvim-lsp/after,~/.local/share/nvim/lazy/nvim/after
set scrolloff=8
set shiftwidth=2
set showtabline=0
set smartcase
set smartindent
set softtabstop=2
set spelllang=en_us
set splitbelow
set splitright
set noswapfile
set tabline=%!v:lua.nvim_bufferline()
set tabstop=2
set termguicolors
set timeoutlen=500
set updatetime=50
set window=40
" vim: set ft=vim :
