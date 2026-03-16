-- ┌─────────────────┐
-- │ Custom mappings │
-- └─────────────────┘
--
-- This file contains definitions of custom general and Leader mappings.

-- General mappings ===========================================================

-- Use this section to add custom general mappings. See `:h vim.keymap.set()`.

-- An example helper to create a Normal mode mapping
local nmap = function(lhs, rhs, desc)
  -- See `:h vim.keymap.set()`
  vim.keymap.set('n', lhs, rhs, { desc = desc })
end

nmap("<C-d>", "<C-d>zz", 'Half page down')
nmap("<C-u>", "<C-u>zz", 'Half page up')
nmap("n", "nzzzv", "Next search result(centered)")
nmap("N", "Nzzzv", "Previous search result(centered)")

-- Paste linewise before/after current line
-- Usage: `yiw` to yank a word and `]p` to put it on the next line.
-- nmap('[p', '<Cmd>exe "iput! " . v:register<CR>', 'Paste Above')
-- nmap(']p', '<Cmd>exe "iput "  . v:register<CR>', 'Paste Below')

-- Many general mappings are created by 'mini.basics'. See 'plugin/30_mini.lua'

-- stylua: ignore start
-- The next part (until `-- stylua: ignore end`) is aligned manually for easier
-- reading. Consider preserving this or remove `-- stylua` lines to autoformat.

-- Leader mappings ============================================================

-- Neovim has the concept of a Leader key (see `:h <Leader>`). It is a configurable
-- key that is primarily used for "workflow" mappings (opposed to text editing).
-- Like "open file explorer", "create scratch buffer", "pick from buffers".
--
-- In 'plugin/10_options.lua' <Leader> is set to <Space>, i.e. press <Space>
-- whenever there is a suggestion to press <Leader>.
--
-- This config uses a "two key Leader mappings" approach: first key describes
-- semantic group, second key executes an action. Both keys are usually chosen
-- to create some kind of mnemonic.
-- Example: `<Leader>f` groups "find" type of actions; `<Leader>ff` - find files.
-- Use this section to add Leader mappings in a structural manner.
--
-- Usually if there are global and local kinds of actions, lowercase second key
-- denotes global and uppercase - local.
-- Example: `<Leader>fs` / `<Leader>fS` - find workspace/document LSP symbols.
--
-- Many of the mappings use 'mini.nvim' modules set up in 'plugin/30_mini.lua'.

-- Create a global table with information about Leader groups in certain modes.
-- This is used to provide 'mini.clue' with extra clues.
-- Add an entry if you create a new group.
Config.leader_group_clues = {
  { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
  { mode = 'n', keys = '<Leader>e', desc = '+Explore/Edit' },
  { mode = 'n', keys = '<Leader>f', desc = '+Find' },
  -- { mode = 'n', keys = '<Leader>g', desc = '+Git' },
  { mode = 'n', keys = '<Leader>l', desc = '+Language' },
  -- { mode = 'n', keys = '<Leader>m', desc = '+Map' },
  { mode = 'n', keys = '<Leader>o', desc = '+Other' },
  -- { mode = 'n', keys = '<Leader>s', desc = '+Session' },
  -- { mode = 'n', keys = '<Leader>t', desc = '+Terminal' },
  -- { mode = 'n', keys = '<Leader>v', desc = '+Visits' },

  -- { mode = 'x', keys = '<Leader>g', desc = '+Git' },
  { mode = 'x', keys = '<Leader>l', desc = '+Language' },
}

-- Helpers for a more concise `<Leader>` mappings.
-- Most of the mappings use `<Cmd>...<CR>` string as a right hand side (RHS) in
-- an attempt to be more concise yet descriptive. See `:h <Cmd>`.
-- This approach also doesn't require the underlying commands/functions to exist
-- during mapping creation: a "lazy loading" approach to improve startup time.
local nmap_leader = function(suffix, rhs, desc)
  vim.keymap.set('n', '<Leader>' .. suffix, rhs, { desc = desc })
end
local xmap_leader = function(suffix, rhs, desc)
  vim.keymap.set('x', '<Leader>' .. suffix, rhs, { desc = desc })
end

-- b is for 'Buffer'. Common usage:
-- - `<Leader>bs` - create scratch (temporary) buffer
-- - `<Leader>ba` - navigate to the alternative buffer
-- - `<Leader>bw` - wipeout (fully delete) current buffer
local new_scratch_buffer = function()
  vim.api.nvim_win_set_buf(0, vim.api.nvim_create_buf(true, true))
end

nmap_leader('ba', '<Cmd>b#<CR>', 'Alternate')
nmap_leader('bd', '<Cmd>lua MiniBufremove.delete()<CR>', 'Delete')
nmap_leader('bD', '<Cmd>lua MiniBufremove.delete(0, true)<CR>', 'Delete!')
nmap_leader('bs', new_scratch_buffer, 'Scratch')
nmap_leader('bw', '<Cmd>lua MiniBufremove.wipeout()<CR>', 'Wipeout')
nmap_leader('bW', '<Cmd>lua MiniBufremove.wipeout(0, true)<CR>', 'Wipeout!')

-- e is for 'Explore' and 'Edit'. Common usage:
-- - `<Leader>ed` - open explorer at current working directory
-- - `<Leader>ef` - open directory of current file (needs to be present on disk)
-- - `<Leader>ei` - edit 'init.lua'
-- - All mappings that use `edit_plugin_file` - edit 'plugin/' config files
-- local edit_plugin_file = function(filename)
--   return string.format('<Cmd>edit %s/plugin/%s<CR>', vim.fn.stdpath('config'), filename)
-- end

local explore_quickfix = function()
  vim.cmd(vim.fn.getqflist({ winid = true }).winid ~= 0 and 'cclose' or 'copen')
end

local explore_toggle = function(opts)
  local minifiles = require("mini.files")
  if not minifiles.close() then minifiles.open(opts) end
end

nmap_leader('e', explore_toggle, 'Directory')
nmap_leader('Ef', function() explore_toggle(vim.api.nvim_buf_get_name(0)) end, 'File directory')
nmap_leader('En', '<Cmd>lua MiniNotify.show_history()<CR>', 'Notifications')
nmap_leader('Eq', explore_quickfix, 'Quickfix list')

-- f is for 'Fuzzy Find'. Common usage:
-- - `<Leader>ff` - find files; for best performance requires `ripgrep`
-- - `<Leader>fg` - find inside files; requires `ripgrep`
-- - `<Leader>fh` - find help tag
-- - `<Leader>fr` - resume latest picker
-- - `<Leader>fv` - all visited paths; requires 'mini.visits'
--
-- All these use 'mini.pick'. See `:h MiniPick-overview` for an overview.
nmap_leader('f/', '<Cmd>Pick history scope="/"<CR>', '"/" history')
nmap_leader('f:', '<Cmd>Pick history scope=":"<CR>', '":" history')
nmap_leader('fb', '<Cmd>Pick buffers<CR>', 'Buffers')
nmap_leader('fd', '<Cmd>Pick diagnostic scope="all"<CR>', 'Diagnostic workspace')
nmap_leader('fD', '<Cmd>Pick diagnostic scope="current"<CR>', 'Diagnostic buffer')
nmap_leader('ff', '<Cmd>Pick files<CR>', 'Files')
nmap_leader('fg', '<Cmd>Pick grep_live<CR>', 'Grep live')
nmap_leader('fG', '<Cmd>Pick grep pattern="<cword>"<CR>', 'Grep current word')
nmap_leader('fh', '<Cmd>Pick help<CR>', 'Help tags')
nmap_leader('fH', '<Cmd>Pick hipatterns<CR>', 'Hipatterns')
nmap_leader('fR', '<Cmd>Pick resume<CR>', 'Resume')
nmap_leader('fk', '<Cmd>Pick keymaps<CR>', 'Keymaps')
nmap_leader('fr', '<Cmd>Pick lsp scope="references"<CR>', 'References (LSP)')
nmap_leader('fs', '<Cmd>Pick lsp scope="workspace_symbol_live"<CR>', 'Symbols workspace (live)')
nmap_leader('fS', '<Cmd>Pick lsp scope="document_symbol"<CR>', 'Symbols document')
nmap_leader('fz', '<Cmd>Pick spellsuggest<CR>', 'SpellSuggest')

nmap_leader('fq', explore_quickfix, 'Quickfix')

-- l is for 'Language'. Common usage:
-- - `<Leader>ld` - show more diagnostic details in a floating window
-- - `<Leader>lr` - perform rename via LSP
-- - `<Leader>ls` - navigate to source definition of symbol under cursor
--
-- NOTE: most LSP mappings represent a more structured way of replacing built-in
-- LSP mappings (like `:h gra` and others). This is needed because `gr` is mapped
-- by an "replace" operator in 'mini.operators' (which is more commonly used).
nmap_leader('la', '<Cmd>lua vim.lsp.buf.code_action()<CR>', 'Actions')
nmap_leader('ld', '<Cmd>lua vim.diagnostic.open_float()<CR>', 'Diagnostic popup')
nmap_leader('lf', '<Cmd>lua require("conform").format()<CR>', 'Format')
nmap_leader('li', '<Cmd>lua vim.lsp.buf.implementation()<CR>', 'Implementation')
nmap_leader('lh', '<Cmd>lua vim.lsp.buf.hover()<CR>', 'Hover')
nmap_leader('lr', '<Cmd>lua vim.lsp.buf.rename()<CR>', 'Rename')
nmap_leader('lR', '<Cmd>lua vim.lsp.buf.references()<CR>', 'References')
nmap_leader('ls', '<Cmd>lua vim.lsp.buf.definition()<CR>', 'Source definition')
nmap_leader('lt', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', 'Type definition')

xmap_leader('lf', '<Cmd>lua require("conform").format()<CR>', 'Format selection')

-- m is for 'Map'. Common usage:
-- - `<Leader>mt` - toggle map from 'mini.map' (closed by default)
-- - `<Leader>mf` - focus on the map for fast navigation
-- - `<Leader>ms` - change map's side (if it covers something underneath)
-- nmap_leader('mf', '<Cmd>lua MiniMap.toggle_focus()<CR>', 'Focus (toggle)')
-- nmap_leader('mr', '<Cmd>lua MiniMap.refresh()<CR>',      'Refresh')
-- nmap_leader('ms', '<Cmd>lua MiniMap.toggle_side()<CR>',  'Side (toggle)')
-- nmap_leader('mt', '<Cmd>lua MiniMap.toggle()<CR>',       'Toggle')

-- o is for 'Other'. Common usage:
-- - `<Leader>oz` - toggle between "zoomed" and regular view of current buffer
-- nmap_leader('or', '<Cmd>lua MiniMisc.resize_window()<CR>', 'Resize to default width')
nmap_leader('ot', '<Cmd>lua MiniTrailspace.trim()<CR>', 'Trim trailspace')
-- nmap_leader('oz', '<Cmd>lua MiniMisc.zoom()<CR>',          'Zoom toggle')

-- s is for 'Session'. Common usage:
-- - `<Leader>sn` - start new session
-- - `<Leader>sr` - read previously started session
-- - `<Leader>sd` - delete previously started session
-- local session_new = 'MiniSessions.write(vim.fn.input("Session name: "))'

-- nmap_leader('sd', '<Cmd>lua MiniSessions.select("delete")<CR>', 'Delete')
-- nmap_leader('sn', '<Cmd>lua ' .. session_new .. '<CR>',         'New')
-- nmap_leader('sr', '<Cmd>lua MiniSessions.select("read")<CR>',   'Read')
-- nmap_leader('sw', '<Cmd>lua MiniSessions.write()<CR>',          'Write current')

-- t is for 'Terminal'
-- nmap_leader('tT', '<Cmd>horizontal term<CR>', 'Terminal (horizontal)')
-- nmap_leader('tt', '<Cmd>vertical term<CR>',   'Terminal (vertical)')

-- v is for 'Visits'. Common usage:
-- - `<Leader>vv` - add    "core" label to current file.
-- - `<Leader>vV` - remove "core" label to current file.
-- - `<Leader>vc` - pick among all files with "core" label.
local make_pick_core = function(cwd, desc)
  return function()
    local sort_latest = MiniVisits.gen_sort.default({ recency_weight = 1 })
    local local_opts = { cwd = cwd, filter = 'core', sort = sort_latest }
    MiniExtra.pickers.visit_paths(local_opts, { source = { name = desc } })
  end
end

-- nmap_leader('vc', make_pick_core('',  'Core visits (all)'),       'Core visits (all)')
-- nmap_leader('vC', make_pick_core(nil, 'Core visits (cwd)'),       'Core visits (cwd)')
-- nmap_leader('vv', '<Cmd>lua MiniVisits.add_label("core")<CR>',    'Add "core" label')
-- nmap_leader('vV', '<Cmd>lua MiniVisits.remove_label("core")<CR>', 'Remove "core" label')
-- nmap_leader('vl', '<Cmd>lua MiniVisits.add_label()<CR>',          'Add label')
-- nmap_leader('vL', '<Cmd>lua MiniVisits.remove_label()<CR>',       'Remove label')
-- stylua: ignore end
