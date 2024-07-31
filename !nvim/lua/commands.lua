vim.api.nvim_create_user_command('Young', function()
	if vim.fn.getcwd() == os.getenv('HOME') then vim.api.nvim_set_current_dir('~/prog/dotfiles') end
	local file = io.open('/home/axlefublr/.local/share/youngest_nvim_file', 'r')
	if not file then return end
	local stored_path = file:read('*a')
	file:close()
	if stored_path and stored_path ~= '' then vim.cmd.edit(stored_path) end
end, {})
