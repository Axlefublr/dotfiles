vim.api.nvim_create_user_command('Young', function()
	if vim.fn.getcwd() == os.getenv('HOME') then vim.api.nvim_set_current_dir('~/prog/dotfiles') end
	local file = io.open('/home/axlefublr/.local/share/youngest_nvim_file', 'r')
	if not file then return end
	local stored_path = file:read('*a')
	file:close()
	if stored_path and stored_path ~= '' then vim.cmd.edit(stored_path) end
end, {})

vim.api.nvim_create_user_command('NeolineNi', function()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local text = vim.fn.join(lines, '\n')
	local file = io.open('/tmp/ni-output', 'w+')
	if not file then return end
	file:write(text)
	file:close()
end, {})

vim.api.nvim_create_user_command('NeolineClipboard', function()
	vim.bo.filetype = 'markdown'
	---@diagnostic disable-next-line: redundant-parameter, param-type-mismatch
	local lines = vim.fn.getreg('+', 1, true)
	---@diagnostic disable-next-line: param-type-mismatch
	vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
	env.acmd('BufUnload', nil, function()
		local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
		vim.fn.setreg('+', vim.fn.join(lines, '\n'))
	end)
end, {})

vim.api.nvim_create_user_command('NeolineClipboardEmpty', function()
	vim.bo.filetype = 'markdown'
	vim.cmd('startinsert')
	env.acmd('BufUnload', nil, function()
		local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
		vim.fn.setreg('+', vim.fn.join(lines, '\n'))
	end)
end, {})

vim.api.nvim_create_user_command('KittyInput', function()
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
end, {})
