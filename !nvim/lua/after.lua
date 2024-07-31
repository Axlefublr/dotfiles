env.saquire('mappings')

env.do_and_acmd(true, function()
	vim.fn.matchadd(env.high({ fg = env.color.level, bg = env.color.orange, bold = true }), 'FIXME:\\=')
	vim.fn.matchadd(env.high({ fg = env.color.level, bg = env.color.green, bold = true }), 'TODO:\\=')
	vim.fn.matchadd(env.high({ fg = env.color.level, bg = env.color.cyan, bold = true }), 'MOVE:\\=')
end, { event = 'WinEnter' })

env.do_and_acmd(true, function()
	local spaces = vim.bo.shiftwidth
	local built_chars = 'tab:← ,multispace:·,leadmultispace:' .. (' '):rep(spaces - 1)
	vim.opt_local.listchars = built_chars
end, { event = 'BufEnter' })

env.emit('User', 'WayAfter')
