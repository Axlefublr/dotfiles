local opts = {
	defaut_file_explorer = true,
	columns = {
		'icon',
		-- 'permissions',
	},
	win_options = {
		wrap = true,
	},
	delete_to_trash = true,
	skip_confirm_for_simple_edits = true,
	keymaps = {
		['<a-d>'] = 'actions.refresh',
		['<CR>'] = 'actions.select',
		['K'] = 'actions.close',
		['<a-i>'] = 'actions.select_vsplit',
		['<a-o>'] = 'actions.select_split',
		['<a-u>'] = 'actions.add_to_qflist',
		['<a-U>'] = 'actions.send_to_qflist',
		['go'] = 'actions.parent',
		[',dc'] = 'actions.open_cwd',
		['gq'] = 'actions.cd',
		['gO'] = 'actions.change_sort',
		['gx'] = 'actions.open_external',
		['gy'] = 'actions.copy_entry_path',
		['gt'] = 'actions.toggle_trash'
	},
	use_default_keymaps = false,
	view_options = {
		show_hidden = true,
		is_always_hidden = function(name, _) return name == '..' or name == '.git' end,
		natural_order = true,
	},
	float = {
		padding = 0
	}
}

return {
	'stevearc/oil.nvim',
	keys = {
		{ 'gq', '<cmd>Oil<cr>' },
	},
	cmd = {
		'Oil'
	},
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		require('oil').setup(opts)
		vim.api.nvim_set_hl(0, 'OilDir', { fg = Colors.white })
		vim.api.nvim_set_hl(0, 'OilDirIcon', { fg = Colors.yellow })
		vim.api.nvim_set_hl(0, 'OilLink', { fg = Colors.mint })
		vim.api.nvim_set_hl(0, 'OilLinkTarget', { fg = Colors.red })

		vim.api.nvim_set_hl(0, 'OilTrash', { fg = Colors.red })
	end,
}
