env.saquire('mappings')

env.do_and_acmd(true, function()
	vim.fn.matchadd(env.high({ fg = env.color.level, bg = env.color.orange, bold = true }), 'FI' .. 'XME:\\=')
	vim.fn.matchadd(env.high({ fg = env.color.level, bg = env.color.green, bold = true }), 'TO' .. 'DO:\\=')
	vim.fn.matchadd(env.high({ fg = env.color.level, bg = env.color.cyan, bold = true }), 'MO' .. 'VE:\\=')
end, { event = 'WinEnter' })

env.do_and_acmd(true, function()
	local spaces = vim.bo.shiftwidth
	local built_chars = 'tab:→ ,multispace:·,leadmultispace:' .. (' '):rep(spaces - 1)
	vim.opt_local.listchars = built_chars
end, { event = 'BufEnter' })

env.do_and_acmd(
	function() return vim.fn.expand('%') == '/tmp/pjs' end,
	function()
		vim.b.match_paths = vim.fn.matchadd(env.high({ fg = env.color.blush }), '^\\(dotfile\\|proj\\|forks\\|stored\\).\\+')
	end,
	{ event = 'BufEnter', pattern = '/tmp/pjs' }
)
env.acmd('BufLeave', '/tmp/pjs', function() vim.fn.matchdelete(vim.b.match_paths) end)
env.do_and_acmd(function() return vim.fn.expand('%') == '/tmp/pjs' end, function()
	env.bmap('n', 'gf', function()
		local line = vim.fn.getline('.')
		vim.cmd.edit(vim.fn.expand('~') .. '/prog/' .. line .. '/project.txt')
	end)
	return true
end, { event = 'BufEnter', pattern = '/tmp/pjs' })

env.acmd('FileType', 'qf', function() env.bmap('n', 'cc', '<CR>') end)

env.emit('User', 'WayAfter')

env.do_and_acmd(function() return vim.fn.expand('%:t') == 'Cargo.toml' end, function()
	require('cmp').setup.buffer({ sources = { { name = 'crates' } } })
	require('crates')
end, { event = 'BufRead', pattern = 'Cargo.toml' })

env.do_and_acmd(function() return vim.bo.filetype == 'lua' end, function()
	require('lazydev')
	return true
end, { event = 'FileType', pattern = 'lua' })
