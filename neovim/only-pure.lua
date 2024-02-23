local function closeEditor()
	local bufnr = vim.api.nvim_get_current_buf()
	if vim.api.nvim_buf_get_name(bufnr) == '' then
		vim.cmd('q!')
	else
		vim.cmd('x')
	end
end
vim.keymap.set('n', 'K', closeEditor)
vim.keymap.set('i', '<f1>', closeEditor)

local function close_without_saving()
	vim.cmd('q!')
end
vim.keymap.set('n', ',K', close_without_saving)

local function save_vim()
	Remove_highlighting()
	vim.cmd('w')
end
vim.keymap.set('', 'U', save_vim)
vim.keymap.set('', '<Space>', save_vim)