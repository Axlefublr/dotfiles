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

env.acmd({ 'RecordingLeave', 'VimEnter' }, nil, function()
	env.map('n', 'gX', 'qe')
	env.map('i', '<A-x>', '<Esc>qegi')
end)
env.acmd('RecordingEnter', nil, function()
	env.map('n', 'gX', 'q')
	env.map('i', '<A-x>', '<Esc>qgi')
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

env.acmd('CmdwinEnter', nil, function() env.bmap('n', '<CR>', '<CR>') end)

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
env.acmd('FileType', 'help', function()
	vim.opt_local.list = false
	vim.opt.relativenumber = true
	vim.cmd.wincmd('_') -- maximizes the current window, because there's no count passed. `<C-w>_`
end)
env.acmd('FileType', 'man', function()
	vim.keymap.del('n', 'j', { buffer = true })
	vim.keymap.del('n', 'k', { buffer = true })
	vim.keymap.del('n', 'q', { buffer = true })
	vim.cmd.wincmd('_')
end)
env.acmd('FileType', 'git', function()
	pcall(vim.keymap.del, { 'n', 'x', 'o' }, 'K', { buffer = true })
	pcall(vim.keymap.del, 'n', '<CR>', { buffer = true })
	env.bmap('n', '>', ':<C-U>exe <SNR>37_GF("edit")<CR>')
end)

env.acmd('User', 'VeryLazy', function()
	vim.defer_fn(function() env.saquire('after') end, 10)
end, { once = true })
