return {
	'stevearc/oil.nvim',
	lazy = false,
	keys = {
		{ 'gq', function() vim.cmd('Oil') end },
	},
	cmd = {
		'Oil',
	},
	opts = function(_, opts)
		vim.api.nvim_set_hl(0, 'OilDir', { fg = Colors.white })
		vim.api.nvim_set_hl(0, 'OilDirIcon', { fg = Colors.shell_yellow })
		vim.api.nvim_set_hl(0, 'OilLink', { fg = Colors.mint })
		vim.api.nvim_set_hl(0, 'OilLinkTarget', { fg = Colors.red })

		vim.api.nvim_set_hl(0, 'OilTrash', { fg = Colors.orange })
		vim.api.nvim_set_hl(0, 'OilRestore', { fg = Colors.purple })
		vim.api.nvim_set_hl(0, 'OilPurge', { fg = Colors.red })
		vim.api.nvim_set_hl(0, 'OilMove', { fg = Colors.mint })
		vim.api.nvim_set_hl(0, 'OilMove', { fg = Colors.yellow })

		vim.api.nvim_create_autocmd('FileType', {
			pattern = 'oil',
			callback = function()
				vim.keymap.set('n', '>', function()
					local file_name = require('oil').get_cursor_entry().name
					local function get_externality(file_name)
						local external_extensions = { 'mp4', 'webm', 'mkv', 'jpg', 'png', 'gif', 'svg' }
						for _, extension in ipairs(external_extensions) do
							if file_name:match('%.' .. extension .. '$') then return true end
						end
						return false
					end
					local is_external = get_externality(file_name)
					if is_external then
						require('oil.actions').open_external.callback()
					else
						require('oil.actions').select.callback()
					end
				end, { buffer = true })

				vim.keymap.set('n', 'gq', function()
					local oil_cwd = require('oil').get_current_dir()
					require('oil.actions').cd.callback()
					os.execute('zoxide add "' .. oil_cwd .. '"')
				end, { buffer = true })
			end,
		})

		return require('astrocore').extend_tbl(opts, {
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
				-- ['gq'] = 'actions.cd',
				['go'] = 'actions.change_sort',
				['ga'] = 'actions.open_external',
				['gy'] = 'actions.copy_entry_path',
				['gt'] = 'actions.toggle_trash',
			},
			use_default_keymaps = false,
			experimental_watch_for_changes = true,
			view_options = {
				show_hidden = true,
				is_always_hidden = function(name, _) return name == '..' or name == '.git' end,
				natural_order = true,
			},
			float = {
				padding = 0,
			},
		})
	end,
}
