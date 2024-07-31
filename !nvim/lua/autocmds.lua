env.acmd('User', 'NeolineNi', function() -- MOVE: to be commands
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local text = vim.fn.join(lines, '\n')
	local file = io.open('/tmp/ni-output', 'w+')
	if not file then return end
	file:write(text)
	file:close()
end)
env.acmd('User', 'NeolineClipboard', function()
	vim.bo.filetype = 'markdown'
	---@diagnostic disable-next-line: redundant-parameter, param-type-mismatch
	local lines = vim.fn.getreg('+', 1, true)
	---@diagnostic disable-next-line: param-type-mismatch
	vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
	env.acmd('BufUnload', nil, function()
		local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
		vim.fn.setreg('+', vim.fn.join(lines, '\n'))
	end)
end)
env.acmd('User', 'NeolineClipboard empty', function()
	vim.bo.filetype = 'markdown'
	vim.cmd('startinsert')
	env.acmd('BufUnload', nil, function()
		local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
		vim.fn.setreg('+', vim.fn.join(lines, '\n'))
	end)
end)

env.acmd('BufUnload', '/dev/shm/fish_edit_commandline.fish', function()
	local file = io.open('/dev/shm/fish_edit_commandline_cursor', 'w+')
	if not file then return end
	local position = vim.api.nvim_win_get_cursor(0)
	local line = position[1]
	local column = position[2]
	file:write(line .. ' ' .. column + 1)
	file:close()
end)

env.acmd({ 'BufEnter', 'FocusGained' }, nil, function(ev)
	local path = vim.api.nvim_buf_get_name(ev.buf)
	if not path or path == '' then return end
	local file = io.open('/home/axlefublr/.local/share/youngest_nvim_file', 'w+')
	if not file then return end
	file:write(path)
	file:close()
end)

env.acmd('User', 'KittyInput', function()
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

	vim.fn.matchadd(env.high({ fg = env.color.shell_pink, bold = true }), '^[\\/~].*\\ze 󱕅')
	vim.fn.matchadd(env.high({ fg = env.color.shell_yellow }), '󱕅')
	vim.fn.matchadd(env.high({ fg = env.color.shell_purple }), '\\S\\+')
	vim.fn.matchadd(env.high({ fg = env.color.shell_red, bold = true }), '󱎘\\d\\+')
	vim.fn.matchadd(env.high({ fg = env.color.shell_cyan }), '\\d\\+')
	vim.fn.matchadd(env.high({ fg = env.color.green }), '󱕅 \\zs.*')

	local pattern = require('harp').filetype_search_get_pattern('f', '')
	vim.fn.setreg('/', pattern)

	vim.keymap.set('n', 'gy', 'jVnko')
end)

env.acmd(
	'BufEnter',
	'/tmp/pjs',
	function() vim.b.match_paths = vim.fn.matchadd(env.high({ fg = env.color.blush }), '^\\~.*') end
)
env.acmd('BufLeave', '/tmp/pjs', function() vim.fn.matchdelete(vim.b.match_paths) end)

env.acmd({ 'RecordingLeave', 'VimEnter' }, nil, function()
	vim.keymap.set('n', 'gX', 'qe')
	vim.keymap.set('i', '<A-x>', '<Esc>qegi')
end)
env.acmd('RecordingEnter', nil, function()
	vim.keymap.set('n', 'gX', 'q')
	vim.keymap.set('i', '<A-x>', '<Esc>qgi')
end)

env.acmd('InsertEnter', nil, 'set nohlsearch')
env.acmd('InsertLeave', nil, 'set hlsearch')

env.acmd({ 'BufLeave', 'FocusLost' }, nil, function()
	pcall(vim.cmd --[[@as function]], 'silent update')
end)

env.acmd('TextYankPost', nil, function() vim.highlight.on_yank() end)

env.acmd({ 'FocusGained', 'TermClose', 'TermLeave' }, nil, 'checktime')

env.acmd('BufWritePre', nil, function(args) -- create parent directories when saving a new file
	if not env.is_valid(args.buf) then return end
	---@diagnostic disable-next-line: undefined-field
	vim.fn.mkdir(vim.fn.fnamemodify(vim.loop.fs_realpath(args.match) or args.match, ':p:h'), 'p')
end)

env.acmd('BufEnter', nil, function()
	local spaces = vim.bo.shiftwidth
	local built_chars = 'tab:← ,multispace:·,leadmultispace:' .. (' '):rep(spaces - 1)
	vim.opt_local.listchars = built_chars
end)

env.acmd('CmdwinEnter', nil, function() vim.keymap.set('n', '<CR>', '<CR>', { buffer = true }) end)

env.acmd({ 'VimEnter', 'WinEnter' }, nil, function()
	vim.fn.matchadd(env.high({ fg = env.color.level, bg = env.color.orange, bold = true }), 'FIXME:\\=')
	vim.fn.matchadd(env.high({ fg = env.color.level, bg = env.color.green, bold = true }), 'TODO:\\=')
	vim.fn.matchadd(env.high({ fg = env.color.level, bg = env.color.cyan, bold = true }), 'MOVE:\\=')
end)

-- тук тук

env.acmd({ 'BufRead', 'BufNewFile' }, '*.XCompose', 'setfiletype xcompose')
env.acmd({ 'BufRead', 'BufNewFile' }, '*.rasi', 'setfiletype rasi')
env.acmd({ 'BufRead', 'BufNewFile' }, 'kitty.conf', 'setfiletype conf')

-- filetype specific

env.acmd('FileType', 'gitcommit', 'startinsert')
env.acmd('FileType', 'fish', function()
	vim.opt_local.expandtab = true
	vim.opt_local.shiftwidth = 4
end)
env.acmd('FileType', 'help', function() vim.opt_local.list = false end)
env.acmd('FileType', 'man', function()
	vim.keymap.del('n', 'j', { buffer = true })
	vim.keymap.del('n', 'k', { buffer = true })
	vim.keymap.del('n', 'q', { buffer = true })
end)
env.acmd('FileType', 'git', function()
	pcall(vim.keymap.del, { 'n', 'x', 'o' }, 'K', { buffer = true })
	pcall(vim.keymap.del, 'n', '<CR>', { buffer = true })
	vim.keymap.set('n', '>', ':<C-U>exe <SNR>37_GF("edit")<CR>', { buffer = true })
end)

env.acmd('User', 'VeryLazy', function()
	vim.defer_fn(function() env.saquire('after') end, 10)
end, { once = true })
