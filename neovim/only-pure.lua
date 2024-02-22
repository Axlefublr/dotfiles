local function closeEditor()
	local bufnr = vim.api.nvim_get_current_buf()
	if vim.api.nvim_buf_get_name(bufnr) == '' then
		Cmd('q!')
	else
		Cmd('x')
	end
end
Map("n", "K", closeEditor)
Map("i", "<f1>", closeEditor)

local function close_without_saving()
	Cmd("q!")
end
Map("n", ",K", close_without_saving)

local function save_vim() Cmd("w") end
Map("", "U", save_vim)
Map("", "<Space>", save_vim)