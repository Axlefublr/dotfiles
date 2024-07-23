local opts_table = {
	features = {
		large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
		autopairs = true,
		cmp = true,
		diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
		highlighturl = false, -- highlight URLs at start
		notifications = true, -- enable notifications at start
	},
	-- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
	diagnostics = {
		-- virtual_text = {
		-- 	virt_text_pos = 'eol',
		-- 	source = 'if_many',
		-- 	spacing = 0,
		-- },
		virtual_text = false,
		underline = true,
		signs = false,
		virtual_lines = false,
	},
	options = {
		opt = {
			-- foldclose = 'all',
			-- showbreak = '󱞩 ',
			-- showtabline = 0,
			autowrite = true,
			autowriteall = true,
			background = 'dark',
			backup = false,
			breakindent = false,
			clipboard = 'unnamedplus',
			cmdwinheight = 1,
			colorcolumn = '',
			cpoptions = 'aABceFs',
			cursorline = true,
			cursorlineopt = 'both',
			eol = false,
			expandtab = false,
			fillchars = 'eob: ,fold: ',
			fixeol = false,
			foldcolumn = '1',
			foldlevel = 0,
			foldlevelstart = 0,
			foldminlines = 0,
			foldtext = '',
			gdefault = true,
			hlsearch = true,
			ignorecase = true,
			inccommand = 'nosplit',
			langmap = 'йЙцЦуУкКеЕнНгГшШщЩзЗхХъЪфФыЫвВаАпПрРоОлЛдДжЖэЭяЯчЧсСмМиИтТьЬбБюЮ;qQwWeErRtTyYuUiIoOpP[{]}aAsSdDfFgGhHjJkKlL;:\'\\"zZxXcCvVbBnNmM\\,<.>',
			lazyredraw = false,
			linebreak = false,
			list = true,
			listchars = 'tab:← ,multispace:·',
			matchpairs = '(:),{:},[:],<:>',
			mouse = '',
			number = false,
			numberwidth = 3, -- this weirdly means 2
			relativenumber = true,
			report = 9999,
			scrolloff = 999,
			shiftwidth = 3,
			shortmess = 'finxtTIoOF',
			sidescrolloff = 999,
			signcolumn = 'no',
			smartcase = true,
			smartindent = true,
			smoothscroll = false,
			spell = false,
			splitbelow = true,
			splitright = true,
			startofline = true,
			swapfile = false,
			syntax = 'enable',
			tabstop = 3,
			termguicolors = true,
			timeout = false,
			undofile = true,
			virtualedit = 'block',
			wildcharm = 12, -- is <C-l>
			wildoptions = 'fuzzy,pum',
			wrap = true,
			writebackup = false,
		},
		g = {
			rust_recommended_style = true,
		},
	},
	commands = {
		Young = {
			function()
				if vim.fn.getcwd() == os.getenv('HOME') then vim.api.nvim_set_current_dir('~/prog/dotfiles') end
				local recent = vim.v.oldfiles[1]
				vim.cmd.edit(recent)
			end,
		},
	},
	autocmds = {
		neoline = {
			{
				event = 'User',
				pattern = 'NeolineNi',
				callback = function()
					vim.api.nvim_create_autocmd('BufUnload', {
						callback = function()
							local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
							local text = vim.fn.join(lines, '\n')
							local file = io.open('/tmp/ni-output', 'w+')
							if not file then return end
							file:write(text)
							file:close()
						end,
					})
					return true
				end,
			},
			{
				event = 'User',
				pattern = 'NeolineClipboard',
				callback = function()
					vim.bo.filetype = 'markdown'
					---@diagnostic disable-next-line: redundant-parameter
					local lines = vim.fn.getreg('+', 1, true)
					---@diagnostic disable-next-line: param-type-mismatch
					vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
					vim.api.nvim_create_autocmd('BufUnload', {
						callback = function()
							local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
							vim.fn.setreg('+', vim.fn.join(lines, '\n'))
						end,
					})
					return true
				end,
			},
			{
				event = 'User',
				pattern = 'NeolineClipboard empty',
				callback = function()
					vim.bo.filetype = 'markdown'
					vim.api.nvim_create_autocmd('BufUnload', {
						callback = function()
							local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
							vim.fn.setreg('+', vim.fn.join(lines, '\n'))
						end,
					})
					return true
				end,
			},
		},
		macromode = {
			{
				event = { 'RecordingLeave', 'VimEnter' },
				callback = function()
					vim.keymap.set('n', 'gX', 'qe')
					vim.keymap.set('i', '<A-x>', '<Esc>qegi')
				end,
			},
			{
				event = 'RecordingEnter',
				callback = function()
					vim.keymap.set('n', 'gX', 'q')
					vim.keymap.set('i', '<A-x>', '<Esc>qgi')
				end,
			},
		},
		hlsearch = {
			{
				event = 'InsertEnter',
				callback = function()
					vim.opt.hlsearch = false
				end
			},
			{
				event = 'InsertLeave',
				callback = function()
					vim.opt.hlsearch = true
				end
			},
		},
		fugutive = {
			{
				event = 'FileType',
				pattern = 'git',
				callback = function()
					pcall(vim.keymap.del, { 'n', 'x', 'o' }, 'K', { buffer = true })
					pcall(vim.keymap.del, 'n', '<CR>', { buffer = true })
					vim.keymap.set('n', '>', ':<C-U>exe <SNR>37_GF("edit")<CR>', { buffer = true })
				end
			}
		},
		everything = {
			{
				event = { 'VimEnter', 'WinEnter' },
				callback = function()
					vim.fn.matchadd('OrangeBoldBackground', 'FIXME:\\=')
					vim.fn.matchadd('GreenBoldBackground', 'TODO:\\=')
				end,
			},
			{
				event = { 'BufRead', 'BufNewFile' },
				pattern = '*.XCompose',
				command = 'setfiletype xcompose',
			},
			{
				event = { 'BufRead', 'BufNewFile' },
				pattern = '*.rasi',
				command = 'setfiletype rasi',
			},
			{
				event = { 'BufRead', 'BufNewFile' },
				pattern = 'kitty.conf',
				command = 'setfiletype conf',
			},
			{
				event = 'FileType',
				pattern = 'gitcommit',
				command = 'startinsert',
			},
			{
				event = 'FileType',
				pattern = 'fish',
				callback = function()
					vim.opt_local.expandtab = true
					vim.opt_local.shiftwidth = 4
				end,
			},
			{
				event = 'FileType',
				pattern = 'help',
				callback = function() vim.opt_local.list = false end,
			},
			{
				event = 'FileType',
				pattern = 'man',
				callback = function()
					vim.keymap.del('n', 'j', { buffer = true })
					vim.keymap.del('n', 'k', { buffer = true })
					vim.keymap.del('n', 'q', { buffer = true })
				end,
			},
			{
				event = 'CmdwinEnter',
				callback = function() vim.keymap.set('n', '<CR>', '<CR>', { buffer = true }) end,
			},
			{
				event = 'LspAttach',
				callback = function()
					vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
						border = env.borders,
					})
					vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
						border = env.borders,
					})
				end,
			},
			{ -- Special behavior autocommands
				event = 'BufUnload',
				pattern = '/dev/shm/fish_edit_commandline.fish',
				callback = function()
					local file = io.open('/dev/shm/fish_edit_commandline_cursor', 'w+')
					if file then
						local position = vim.api.nvim_win_get_cursor(0)
						local line = position[1]
						local column = position[2]
						file:write(line .. ' ' .. column + 1)
						file:close()
					end
				end,
			},
			{
				event = 'User',
				pattern = 'KittyInput',
				callback = function()
					vim.opt_local.relativenumber = false
					vim.opt_local.laststatus = 0
					vim.opt_local.showtabline = 0
					vim.opt_local.foldcolumn = '0'
					vim.opt_local.list = false
					vim.opt_local.showbreak = ''
					vim.opt_local.linebreak = false
					vim.opt_local.breakindent = false

					vim.cmd('%s;\\s*$;;e')
					vim.cmd('%s;\\n\\+\\%$;;e')

					vim.fn.matchadd('ShellPinkBold', '^[\\/~].*\\ze 󱕅')
					vim.fn.matchadd('ShellYellow', '󱕅')
					vim.fn.matchadd('ShellPurpleBold', '\\S\\+')
					vim.fn.matchadd('ShellRedBold', '󱎘\\d\\+')
					vim.fn.matchadd('ShellCyan', '\\d\\+')
					vim.fn.matchadd('Green', '󱕅 \\zs.*')

					local pattern = require('harp').filetype_search_get_pattern('f', '')
					vim.fn.setreg('/', pattern)

					vim.keymap.set('n', 'gy', 'jVnko')
				end,
			},
			{
				event = 'BufEnter',
				pattern = '/tmp/pjs',
				callback = function() vim.b.match_paths = vim.fn.matchadd('Blush', '^\\~.*') end,
			},
			{
				event = 'BufLeave',
				pattern = '/tmp/pjs',
				callback = function() vim.fn.matchdelete(vim.b.match_paths) end,
			},
			{
				event = { 'BufLeave', 'FocusLost' },
				callback = function()
					---@diagnostic disable-next-line: param-type-mismatch
					pcall(vim.cmd, 'silent update')
				end,
			},
		},
	},
}

---@type LazySpec
return {
	'AstroNvim/astrocore',
	---@param opts AstroCoreOpts
	opts = function(_, opts)
		---@diagnostic disable-next-line: inject-field
		opts.mappings = nil
		---@diagnostic disable-next-line: undefined-field
		opts.autocmds.bufferline = nil
		---@diagnostic disable-next-line: undefined-field
		opts.autocmds.q_close_windows = nil
		---@diagnostic disable-next-line: undefined-field
		opts.autocmds.autoview = nil
		---@diagnostic disable-next-line: undefined-field
		opts.on_keys.auto_hlsearch = nil
		require('explicit.mappings')
		return require('astrocore').extend_tbl(opts, opts_table)
	end,
}
