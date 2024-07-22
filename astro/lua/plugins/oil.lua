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
		vim.api.nvim_create_autocmd('FileType', {
			pattern = 'oil',
			callback = function()
				vim.keymap.set('n', '>', function()
					local file_name = require('oil').get_cursor_entry().name
					local function get_externality(file_name)
						local external_extensions = env.external_extensions
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

				vim.keymap.set('n', '<Leader>dt', function()
					local oil_cwd = require('oil').get_current_dir()
					require('oil.actions').cd.callback()
					os.execute("zoxide add '" .. oil_cwd .. "'")
				end, { buffer = true })

				vim.keymap.set(
					'n',
					'<Leader>aus',
					function()
						require('astrocore').cmd({
							'kitten',
							'@',
							'launch',
							'--type',
							'tab',
							'--cwd',
							require('oil').get_current_dir(),
						})
					end,
					{ buffer = true }
				)
				vim.keymap.set(
					'n',
					'<Leader>ais',
					function()
						require('astrocore').cmd({ 'kitten', '@', 'launch', '--cwd', require('oil').get_current_dir() })
					end,
					{ buffer = true }
				)

				vim.keymap.set('n', '<Leader>z', function()
					local register = Get_char('get cd harp: ')
					if register == nil then return end
					local output = require('astrocore').cmd({ 'harp', 'get', 'cd_harps', register, '--path' }, false)
					if output then
						require('oil').open(output)
					else
						vim.notify('cd harp ' .. register .. ' is empty')
					end
				end, { buffer = true })

				vim.keymap.set('n', '<Leader>Z', function()
					local register = Get_char('set cd harp: ')
					if register == nil then return end
					local directory = require('oil').get_current_dir()
					directory = vim.fn.fnamemodify(directory, ':~')
					local output =
						require('astrocore').cmd({ 'harp', 'update', 'cd_harps', register, '--path', directory }, false)
					if output then vim.notify('set cd harp ' .. register) end
				end, { buffer = true })

				vim.keymap.set('n', 'gd', function()
					local buffer_id = vim.api.nvim_win_get_buf(0)
					local id = vim.fn.matchbufline(buffer_id, ';\\zs.*\\ze;', vim.fn.line('.'), vim.fn.line('.'))[1].text
					local link = 'https://www.youtube.com/watch?v=' .. id
					vim.fn.setreg(env.default_register, link)
					vim.notify('compiled link')
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
				foldcolumn = '1'
			},
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			keymaps = {
				['<A-d>'] = 'actions.refresh',
				['<'] = 'actions.parent',
				['K'] = 'actions.close',
				['<C-l>'] = 'actions.select_vsplit',
				['<F6>'] = 'actions.select_split',
				['<A-u>'] = 'actions.add_to_qflist',
				['<A-U>'] = 'actions.send_to_qflist',
				['gq'] = 'actions.open_cwd',
				-- ['gq'] = 'actions.cd',
				['go'] = 'actions.change_sort',
				['ga'] = 'actions.open_external',
				['gy'] = 'actions.copy_entry_path',
				['gt'] = 'actions.toggle_trash',
			},
			use_default_keymaps = false,
			experimental_watch_for_changes = false,
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
