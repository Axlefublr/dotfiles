env.saquire('mappings')

env.do_and_acmd(true, function()
	vim.fn.matchadd(env.high({ fg = env.color.level, bg = env.color.orange, bold = true }), 'FIXME:\\=')
	vim.fn.matchadd(env.high({ fg = env.color.level, bg = env.color.green, bold = true }), 'TODO:\\=')
	vim.fn.matchadd(env.high({ fg = env.color.level, bg = env.color.cyan, bold = true }), 'MOVE:\\=')
end, { event = 'WinEnter' })

env.do_and_acmd(true, function()
	local spaces = vim.bo.shiftwidth
	local built_chars = 'tab:→ ,multispace:·,leadmultispace:' .. (' '):rep(spaces - 1)
	vim.opt_local.listchars = built_chars
end, { event = 'BufEnter' })

env.do_and_acmd(
	function() return vim.fn.expand('%') == '/tmp/pjs' end,
	function() vim.b.match_paths = vim.fn.matchadd(env.high({ fg = env.color.blush }), '^\\~.*') end,
	{ event = 'BufEnter', pattern = '/tmp/pjs' }
)
env.acmd('BufLeave', '/tmp/pjs', function() vim.fn.matchdelete(vim.b.match_paths) end)

env.acmd('FileType', 'qf', function()
	env.bmap('n', 'cc', '<CR>')
end)

env.emit('User', 'WayAfter')

env.do_and_acmd(function() return vim.fn.expand('%:t') == 'Cargo.toml' end, function()
	require('cmp').setup.buffer({ sources = { { name = 'crates' } } })
	require('crates')
end, { event = 'BufRead', pattern = 'Cargo.toml' })

env.do_and_acmd(function() return vim.bo.filetype == 'lua' end, function()
	require('lazydev')
	return true
end, { event = 'FileType', pattern = 'lua' })
