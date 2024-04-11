---@diagnostic disable: param-type-mismatch
vim.keymap.set('n', ',a1', '1<c-w>w')
vim.keymap.set('n', ',a2', '2<c-w>w')
vim.keymap.set('n', ',a3', '3<c-w>w')
vim.keymap.set('n', ',a4', '4<c-w>w')
vim.keymap.set('n', ',a5', '5<c-w>w')
vim.keymap.set('n', ',a6', '6<c-w>w')
vim.keymap.set('n', ',a7', '7<c-w>w')
vim.keymap.set('n', ',a8', '8<c-w>w')
vim.keymap.set('n', ',a9', '9<c-w>w')

vim.keymap.set('n', ',aj', '<c-w>j')
vim.keymap.set('n', ',ak', '<c-w>k')
vim.keymap.set('n', ',ah', '<c-w>h')
vim.keymap.set('n', ',al', '<c-w>l')
vim.keymap.set('n', ',af', '<c-w>J')
vim.keymap.set('n', ',ad', '<c-w>K')
vim.keymap.set('n', ',as', '<c-w>H')
vim.keymap.set('n', ',ag', '<c-w>L')
vim.keymap.set('n', ',au', '<c-w>t')
vim.keymap.set('n', ',ao', '<c-w>b')

vim.keymap.set('n', '<a-h>', '<c-w><')
vim.keymap.set('n', '<a-l>', '<c-w>>')
vim.keymap.set('n', '<c-n>', '<c-w>-')
vim.keymap.set('n', '<c-p>', '<c-w>+')
vim.keymap.set('n', ',aH', '<c-w>h<c-w>|')
vim.keymap.set('n', ',aJ', '<c-w>j<c-w>_')
vim.keymap.set('n', ',aK', '<c-w>k<c-w>_')
vim.keymap.set('n', ',aL', '<c-w>l<c-w>|')
vim.keymap.set('n', ',aU', '<c-w>t<c-w>|<c-w>_')
vim.keymap.set('n', ',aO', '<c-w>b<c-w>|<c-w>_')

-- here
vim.keymap.set('n', ",a'", '<c-w>|')
vim.keymap.set('n', ',av', '<c-w>_')
vim.keymap.set('n', ',ar', '<c-w>r')
vim.keymap.set('n', ',aR', '<c-w>R')
vim.keymap.set('n', ',ay', '<c-w>x')

vim.keymap.set('n', ',ath', function() vim.cmd('leftabove vsplit') end)
vim.keymap.set('n', ',atj', function() vim.cmd('split') end)
vim.keymap.set('n', ',atk', function() vim.cmd('leftabove split') end)
vim.keymap.set('n', ',atl', function() vim.cmd('vsplit') end)

vim.keymap.set('n', ',awh', function() vim.cmd('leftabove vnew') end)
vim.keymap.set('n', ',awj', function() vim.cmd('new') end)
vim.keymap.set('n', ',awk', function() vim.cmd('leftabove new') end)
vim.keymap.set('n', ',awl', function() vim.cmd('vnew') end)
vim.keymap.set('n', ',aww', function() vim.cmd('enew') end)

vim.keymap.set('n', ',a/h', function() vim.cmd('exe "leftabove vertical normal \\<c-w>^"') end)
vim.keymap.set('n', ',a/j', function() vim.cmd('exe "normal \\<c-w>^"') end)
vim.keymap.set('n', ',a/k', function() vim.cmd('exe "leftabove normal \\<c-w>^"') end)
vim.keymap.set('n', ',a/l', function() vim.cmd('exe "vertical normal \\<c-w>^"') end)
vim.keymap.set('n', ',a//', '<c-w>p')
vim.keymap.set({ 'n', 'x' }, ',a?', '<c-^>')

vim.keymap.set('n', ',a;', '<c-w>o')
vim.keymap.set('n', ',ai', '<c-w>=')

vim.keymap.set('n', ',ac', 'gt')
vim.keymap.set('n', ',ax', 'gT')
vim.keymap.set('n', ',aP', '<cmd>tabclose<cr>')
vim.keymap.set('n', ',ap', '<cmd>tabnew<cr>')

local function another_quickfix_entry(to_next, buffer)
	local qflist = vim.fn.getqflist()
	if #qflist == 0 then
		print('quickfix list is empty')
		return
	end

	if vim.v.count > 0 then
		vim.cmd('cc ' .. vim.v.count)
		return
	end

	local qflist_index = vim.fn.getqflist({ idx = 0 }).idx
	local current_buffer = vim.api.nvim_get_current_buf()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]

	if
		qflist_index == 1
		and (qflist[1].bufnr ~= current_buffer
		or qflist[1].lnum ~= current_line)
	then -- If you do have a quickfix list, the first index is automatically selected, meaning that the first time you try to `cnext`, you go to the second quickfix entry, even though you have never actually visited the first one. This is what I mean when I say vim has a bad foundation and is terrible to build upon. We need a modal editor with a better foundation, with no strange behavior like this!
		vim.cmd('cfirst')
		return
	end

	local status = true
	if to_next then
		if buffer then
			status, _ = pcall(vim.cmd, 'cnfile')
		else
			status, _ = pcall(vim.cmd, 'cnext')
		end
		if not status then vim.cmd('cfirst') end
	else
		if buffer then
			status, _ = pcall(vim.cmd, 'cpfile')
		else
			status, _ = pcall(vim.cmd, 'cprev')
		end
		if not status then vim.cmd('clast') end
	end
end
vim.keymap.set('n', '[w', function() another_quickfix_entry(false, false) end)
vim.keymap.set('n', ']w', function() another_quickfix_entry(true, false) end)
vim.keymap.set('n', '[W', function() another_quickfix_entry(false, true) end)
vim.keymap.set('n', ']W', function() another_quickfix_entry(true, true) end)
