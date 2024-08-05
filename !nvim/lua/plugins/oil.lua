---@type LazyPluginSpec
return {
	'stevearc/oil.nvim',
	event = 'User WayAfter',
	keys = {
		{ 'gq', function() vim.cmd('Oil') end },
	},
	cmd = {
		'Oil',
	},
	opts = function()
		---@type oil.setupOpts
		return {
			default_file_explorer = true,
			columns = {
				'icon',
			},
			win_options = {
				wrap = true,
				foldcolumn = '1',
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
			watch_for_changes = true,
			view_options = {
				show_hidden = true,
				is_always_hidden = function(name, _) return name == '..' or name == '.git' end,
				natural_order = true,
			},
			preview = {
				border = env.borders,
				min_width = 0.65,
				min_height = 0.25
			},
			progress = {
				border = env.borders
			}
		}
	end,
	config = function(_, opts)
		env.set_high('OilDir', { link = 'Fg' })
		env.set_high('OilDirIcon', { fg = env.color.shell_yellow })
		env.set_high('OilLink', { fg = env.color.blush })
		env.set_high('OilLinkTarget', { link = 'Red' })
		env.set_high('OilTrash', { link = 'Orange' })
		env.set_high('OilRestore', { link = 'Purple' })
		env.set_high('OilPurge', { link = 'Red' })
		env.set_high('OilMove', { link = 'Yellow' })

		require('oil').setup(opts)

		env.acmd('FileType', 'oil', function()
			env.bmap('n', '>', function()
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
			end)

			env.bmap('n', '<Leader>dt', function()
				local oil_cwd = require('oil').get_current_dir()
				require('oil.actions').cd.callback()
				os.execute("zoxide add '" .. oil_cwd .. "'")
			end)

			env.bmap('n', 'gD', function()
				local options = {
					{
						'chmod +x',
						function()
							local path = require('oil').get_current_dir() .. require('oil').get_cursor_entry().name
							env.shell({ 'chmod', '+x', path })
						end,
					},
				}
				env.select(options, { prompt = ' Action ' })
			end)

			env.bmap('n', '<Leader>z', function()
				local register = env.char('get cd harp: ')
				if register == nil then return end
				local output = env.shell({ 'harp', 'get', 'cd_harps', register, '--path' }):wait()
				if output.code == 0 then
					require('oil').open(output.stdout:trim())
				else
					vim.notify('cd harp ' .. register .. ' is empty')
				end
			end)

			env.bmap('n', '<Leader>Z', function()
				local register = env.char('set cd harp: ')
				if register == nil then return end
				local directory = require('oil').get_current_dir()
				directory = vim.fn.fnamemodify(directory --[[@as string]], ':~')
				local output = env.shell({ 'harp', 'update', 'cd_harps', register, '--path', directory }):wait()
				if output.code == 0 then vim.notify('set cd harp ' .. register) end
			end)

			env.bmap('n', 'gd', function()
				local buffer_id = vim.api.nvim_win_get_buf(0)
				local id = vim.fn.matchbufline(buffer_id, ';\\zs.*\\ze;', vim.fn.line('.'), vim.fn.line('.'))[1].text
				local link = 'https://www.youtube.com/watch?v=' .. id
				vim.fn.setreg(env.default_register, link)
				vim.notify('compiled link')
			end)
		end)
		env.acmd('User', 'OilActionsPost', function(args)
			if args.data.err then return end
			for _, action in ipairs(args.data.actions) do
				if action.type == 'delete' then
					local _, path = require('oil.util').parse_url(action.url)
					local bufnr = vim.fn.bufnr(path)
					if env.is_valid(bufnr) then require('mini.bufremove').wipeout(bufnr, true) end
				end
			end
		end)
	end,
}
