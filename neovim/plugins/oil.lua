local opts = {
	default_file_explorer = true,
	columns = {
		'icon',
	},
	win_options = {
		wrap = true,
	},
	delete_to_trash = true,
	skip_confirm_for_simple_edits = true,
	keymaps = {
		['<a-d>'] = 'actions.refresh',
		['<'] = 'actions.parent',
		['K'] = 'actions.close',
		['<c-l>'] = 'actions.select_vsplit',
		['<f6>'] = 'actions.select_split',
		['<a-u>'] = 'actions.add_to_qflist',
		['<a-U>'] = 'actions.send_to_qflist',
		[',da'] = 'actions.open_cwd',
		['gq'] = 'actions.cd',
		['go'] = 'actions.change_sort',
		['ga'] = 'actions.open_external',
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
	lazy = false,
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
		vim.api.nvim_set_hl(0, 'OilDirIcon', { fg = Colors.shell_yellow })
		vim.api.nvim_set_hl(0, 'OilLink', { fg = Colors.mint })
		vim.api.nvim_set_hl(0, 'OilLinkTarget', { fg = Colors.red })

		vim.api.nvim_set_hl(0, 'OilTrash', { fg = Colors.orange })
		vim.api.nvim_set_hl(0, 'OilRestore', { fg = Colors.purple })
		vim.api.nvim_set_hl(0, 'OilPurge', { fg = Colors.red })

		vim.api.nvim_create_autocmd('FileType', {
			pattern = 'oil',
			callback = function ()
				vim.keymap.set('n', '>', function ()
					local file_name = require('oil').get_cursor_entry().name
					local is_external = file_name:match('%.mp4$') or file_name:match('%.webm$') or file_name:match('%.mkv$')
					if is_external then
						require('oil.actions').open_external.callback()
					else
						require('oil.actions').select.callback()
					end
				end, { buffer = true })
			end
		})
	end,
}
