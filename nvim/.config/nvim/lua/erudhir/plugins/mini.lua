return {
	{ "echasnovski/mini.move", version = false, opts = {}, config = true },
	{ "echasnovski/mini.diff", version = false, opts = { view = { style = "sign" } }, config = true },
	{ "echasnovski/mini.cursorword", version = false, opts = {}, config = true },
	{ "echasnovski/mini.comment", version = false, opts = {}, config = true },
	{
		"echasnovski/mini.pairs",
		version = false,
		event = "VeryLazy",
		config = true,
	},
	{
		"echasnovski/mini.keymap",
		version = false,
		config = function()
			local status, keymap = pcall(require, "mini.keymap")
			if not status then
				return
			end
			local map_combo = keymap.map_combo
			local mode = { "i", "c", "x", "s" }

			map_combo(mode, "jk", "<BS><BS><Esc>")
			-- Escape into Normal mode from Terminal mode
			map_combo("t", "jk", "<BS><BS><C-\\><C-n>")
		end,
	},
	{
		"echasnovski/mini.hipatterns",
		event = { "BufReadPost", "BufNewFile" },
		version = false,
		config = function()
			local hipatterns = require("mini.hipatterns")

			hipatterns.setup({
				highlighters = {
					-- Highlight standalone 'FIX', 'HACK', 'TODO', 'NOTE'
					fixme = { pattern = "%f[%w]()FIX()%f[%W]", group = "MiniHipatternsFixme" },
					hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
					-- Highlight hex color strings (`#rrggbb`) using that color
					hex_color = hipatterns.gen_highlighter.hex_color(),
					hsl_color = {
						pattern = "hsl%(%d+, ?%d+, ?%d+%)",
						group = function(_, match)
							local style = "bg" -- 'fg' or 'bg'
							local hue, saturation, lightness = match:match("hsl%((%d+), ?(%d+), ?(%d+)%)")

							-- Converts HSL to RGB.
							-- https://www.w3.org/TR/css-color-3/#hsl-color
							--
							---@param h string The hue value in degrees.
							---@param s string The saturation value in percent.
							---@param l string The lightness value in percent.
							---@return integer, integer, integer
							local function hsl_to_rgb(h, s, l)
								h, s, l = h % 360, s / 100, l / 100
								if h < 0 then
									h = h + 360
								end
								local function f(n)
									local k = (n + h / 30) % 12
									local a = s * math.min(l, 1 - l)
									return l - a * math.max(-1, math.min(k - 3, 9 - k, 1))
								end
								return f(0) * 255, f(8) * 255, f(4) * 255
							end

							local red, green, blue = hsl_to_rgb(hue, saturation, lightness)
							local hex = string.format("#%02x%02x%02x", red, green, blue)
							return hipatterns.compute_hex_color_group(hex, style)
						end,
					},
				},
			})
		end,
	},
	{
		"echasnovski/mini.bracketed",
		version = false,
		event = "VeryLazy",
		config = function()
			local status, bracketed = pcall(require, "mini.bracketed")
			if not status then
				return
			end

			bracketed.setup({
				buffer = { suffix = "b", options = {} }, -- using cybu
				comment = { suffix = "c", options = {} },
				conflict = { suffix = "x", options = {} },
				-- don't want diagnostic float focus, have in mappings.lua with coc
				-- support too
				diagnostic = { suffix = "d", options = {} },
				file = { suffix = "", options = {} },
				indent = { suffix = "", options = {} }, -- confusing
				jump = { suffix = "", options = {} }, -- redundant
				location = { suffix = "", options = {} },
				oldfile = { suffix = "", options = {} },
				quickfix = { suffix = "q", options = {} },
				treesitter = { suffix = "t", options = {} },
				undo = { suffix = "", options = {} },
				window = { suffix = "", options = {} }, -- broken going to unlisted
				yank = { suffix = "", options = {} }, -- confusing
			})
		end,
	},
	{

		"echasnovski/mini.surround",
		version = false,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local status, surround = pcall(require, "mini.surround")
			if not status then
				return
			end
			surround.setup({
				mappings = {
					add = "<leader>sa", -- Add surrounding in Normal and Visual modes
					delete = "<leader>sd", -- Delete surrounding
					find = "", -- Find surrounding (to the right)
					find_left = "", -- Find surrounding (to the left)
					highlight = "", -- Highlight surrounding
					replace = "<leader>sr", -- Replace surrounding
					update_n_lines = "", -- Update `n_lines`

					suffix_last = "", -- Suffix to search with "prev" method
					suffix_next = "", -- Suffix to search with "next" method
				},
			})
		end,
	},
	{
		"echasnovski/mini.statusline",
		version = false,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"echasnovski/mini.icons",
		},
		config = function()
			local status, line = pcall(require, "mini.statusline")
			if not status then
				return
			end
			line.setup({
				content = {
					active = function()
						local mode, mode_hl = line.section_mode({ trunc_width = 120 })
						local git = line.section_git({ trunc_width = 40 })
						local diff = line.section_diff({ trunc_width = 75 })
						local diagnostics = line.section_diagnostics({ trunc_width = 75 })
						local lsp = line.section_lsp({ trunc_width = 75 })
						local filename = line.section_filename({ trunc_width = 140 })
						local fileinfo = line.section_fileinfo({ trunc_width = 120 })
						local search = line.section_searchcount({ trunc_width = 75 })

						return line.combine_groups({
							{ hl = mode_hl, strings = { mode } },
							{ hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
							"%<", -- Mark general truncate point
							{ hl = "MiniStatuslineFilename", strings = { filename } },
							"%=", -- End left alignment
							{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
							{ hl = mode_hl, strings = { search, "%P %l:%c" } },
						})
					end,
				},
			})
		end,
	},

	{
		"echasnovski/mini.files",
		version = false,
		event = "VeryLazy",
		config = function()
			local status, MiniFiles = pcall(require, "mini.files")
			if not status then
				return
			end
			MiniFiles.setup({
				mappings = {
					close = "q",
					go_in = "l",
					go_in_plus = "L",
					go_out = "h",
					go_out_plus = "H",
					mark_goto = "'",
					mark_set = "m",
					reset = ",",
					reveal_cwd = "?",
					show_help = "g?",
					synchronize = "=",
					trim_left = "<",
					trim_right = ">",
				},
			})

			local minifiles_toggle = function(...)
				if not MiniFiles.close() then
					MiniFiles.open(...)
				end
			end

			vim.keymap.set("n", "<leader>e", function()
				local path = vim.bo.buftype ~= "nofile" and vim.api.nvim_buf_get_name(0) or nil
				minifiles_toggle(path)
			end, { desc = "Open mini.files (cwd)" })

			local nsMiniFiles = vim.api.nvim_create_namespace("mini_files_git")
			local autocmd = vim.api.nvim_create_autocmd

			-- Cache for git status
			local gitStatusCache = {}
			local cacheTimeout = 2000 -- Cache timeout in milliseconds

			local function isSymlink(path)
				local stat = vim.loop.fs_lstat(path)
				return stat and stat.type == "link"
			end

			---@type table<string, {symbol: string, hlGroup: string}>
			---@param status string
			---@return string symbol, string hlGroup
			local function mapSymbols(stat, is_symlink)
				local statusMap = {
    -- stylua: ignore start 
        [" M"] = { symbol = "✹", hlGroup  = "MiniDiffSignChange"}, -- Modified in the working directory
        ["M "] = { symbol = "•", hlGroup  = "MiniDiffSignChange"}, -- modified in index
        ["MM"] = { symbol = "≠", hlGroup  = "MiniDiffSignChange"}, -- modified in both working tree and index
        ["A "] = { symbol = "+", hlGroup  = "MiniDiffSignAdd"   }, -- Added to the staging area, new file
        ["AA"] = { symbol = "≈", hlGroup  = "MiniDiffSignAdd"   }, -- file is added in both working tree and index
        ["D "] = { symbol = "-", hlGroup  = "MiniDiffSignDelete"}, -- Deleted from the staging area
        ["AM"] = { symbol = "⊕", hlGroup  = "MiniDiffSignChange"}, -- added in working tree, modified in index
        ["AD"] = { symbol = "-•", hlGroup = "MiniDiffSignChange"}, -- Added in the index and deleted in the working directory
        ["R "] = { symbol = "→", hlGroup  = "MiniDiffSignChange"}, -- Renamed in the index
        ["U "] = { symbol = "‖", hlGroup  = "MiniDiffSignChange"}, -- Unmerged path
        ["UU"] = { symbol = "⇄", hlGroup  = "MiniDiffSignAdd"   }, -- file is unmerged
        ["UA"] = { symbol = "⊕", hlGroup  = "MiniDiffSignAdd"   }, -- file is unmerged and added in working tree
        ["??"] = { symbol = "?", hlGroup  = "MiniDiffSignDelete"}, -- Untracked files
        ["!!"] = { symbol = "!", hlGroup  = "MiniDiffSignChange"}, -- Ignored files
					-- stylua: ignore end
				}

				local result = statusMap[stat] or { symbol = "?", hlGroup = "NonText" }
				local gitSymbol = result.symbol
				local gitHlGroup = result.hlGroup

				local symlinkSymbol = is_symlink and "↩" or ""

				-- Combine symlink symbol with Git status if both exist
				local combinedSymbol = (symlinkSymbol .. gitSymbol):gsub("^%s+", ""):gsub("%s+$", "")
				-- Change the color of the symlink icon from "MiniDiffSignDelete" to something else
				local combinedHlGroup = is_symlink and "MiniDiffSignDelete" or gitHlGroup

				return combinedSymbol, combinedHlGroup
			end

			---@param cwd string
			---@param callback function
			---@return nil
			local function fetchGitStatus(cwd, callback)
				local function on_exit(content)
					if content.code == 0 then
						callback(content.stdout)
						vim.g.content = content.stdout
					end
				end
				vim.system({ "git", "status", "--ignored", "--porcelain" }, { text = true, cwd = cwd }, on_exit)
			end

			---@param str string|nil
			---@return string
			local function escapePattern(str)
				if not str then
					return ""
				end
				return (str:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1"))
			end

			---@param buf_id integer
			---@param gitStatusMap table
			---@return nil
			local function updateMiniWithGit(buf_id, gitStatusMap)
				vim.schedule(function()
					local nlines = vim.api.nvim_buf_line_count(buf_id)
					local cwd = vim.fs.root(buf_id, ".git")
					local escapedcwd = escapePattern(cwd)
					if vim.fn.has("win32") == 1 then
						escapedcwd = escapedcwd:gsub("\\", "/")
					end

					for i = 1, nlines do
						local entry = MiniFiles.get_fs_entry(buf_id, i)
						if not entry then
							break
						end
						local relativePath = entry.path:gsub("^" .. escapedcwd .. "/", "")
						local status = gitStatusMap[relativePath]

						if status then
							local is_symlink = isSymlink(entry.path)
							local symbol, hlGroup = mapSymbols(status, is_symlink)
							vim.api.nvim_buf_set_extmark(buf_id, nsMiniFiles, i - 1, 0, {
								-- NOTE: if you want the signs on the right uncomment those and comment
								-- the 3 lines after
								-- virt_text = { { symbol, hlGroup } },
								-- virt_text_pos = "right_align",
								sign_text = symbol,
								sign_hl_group = hlGroup,
								priority = 2,
							})
						else
						end
					end
				end)
			end

			-- Thanks for the idea of gettings https://github.com/refractalize/oil-git-status.nvim signs for dirs
			---@param content string
			---@return table
			local function parseGitStatus(content)
				local gitStatusMap = {}
				-- lua match is faster than vim.split (in my experience )
				for line in content:gmatch("[^\r\n]+") do
					local status, filePath = string.match(line, "^(..)%s+(.*)")
					-- Split the file path into parts
					local parts = {}
					for part in filePath:gmatch("[^/]+") do
						table.insert(parts, part)
					end
					-- Start with the root directory
					local currentKey = ""
					for i, part in ipairs(parts) do
						if i > 1 then
							-- Concatenate parts with a separator to create a unique key
							currentKey = currentKey .. "/" .. part
						else
							currentKey = part
						end
						-- If it's the last part, it's a file, so add it with its status
						if i == #parts then
							gitStatusMap[currentKey] = status
						else
							-- If it's not the last part, it's a directory. Check if it exists, if not, add it.
							if not gitStatusMap[currentKey] then
								gitStatusMap[currentKey] = status
							end
						end
					end
				end
				return gitStatusMap
			end

			---@param buf_id integer
			---@return nil
			local function updateGitStatus(buf_id)
				local cwd = vim.uv.cwd()
				if not cwd or not vim.fs.root(cwd, ".git") then
					return
				end

				local currentTime = os.time()
				if gitStatusCache[cwd] and currentTime - gitStatusCache[cwd].time < cacheTimeout then
					updateMiniWithGit(buf_id, gitStatusCache[cwd].statusMap)
				else
					fetchGitStatus(cwd, function(content)
						local gitStatusMap = parseGitStatus(content)
						gitStatusCache[cwd] = {
							time = currentTime,
							statusMap = gitStatusMap,
						}
						updateMiniWithGit(buf_id, gitStatusMap)
					end)
				end
			end

			---@return nil
			local function clearCache()
				gitStatusCache = {}
			end

			local function augroup(name)
				return vim.api.nvim_create_augroup("MiniFiles_" .. name, { clear = true })
			end

			autocmd("User", {
				group = augroup("start"),
				pattern = "MiniFilesExplorerOpen",
				-- pattern = { "minifiles" },
				callback = function()
					local bufnr = vim.api.nvim_get_current_buf()
					updateGitStatus(bufnr)
				end,
			})

			autocmd("User", {
				group = augroup("close"),
				pattern = "MiniFilesExplorerClose",
				callback = function()
					clearCache()
				end,
			})

			autocmd("User", {
				group = augroup("update"),
				pattern = "MiniFilesBufferUpdate",
				callback = function(sii)
					local bufnr = sii.data.buf_id
					local cwd = vim.fn.expand("%:p:h")
					if gitStatusCache[cwd] then
						updateMiniWithGit(bufnr, gitStatusCache[cwd].statusMap)
					end
				end,
			})
		end,
	},
}
