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
				['<Leader>al'] = 'actions.select_vsplit',
				['<Leader>aj'] = 'actions.select_split',
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
			watch_for_changes = false,
			view_options = {
				show_hidden = true,
				is_always_hidden = function(name, _) return name == '..' or name == '.git' end,
				natural_order = true,
			},
			preview = {
				border = env.borders,
				min_width = 0.65,
				min_height = 0.25,
			},
			progress = {
				border = env.borders,
			},
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

		local function oil_tail()
			return vim.fn.fnamemodify(require('oil').get_current_dir() --[[@as string]], ':h:t')
		end

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

				-- ╔══════════════════════════════════════════════════════════════════════╗
				-- ║ If I'm in `content`, big chance I'm watching an anime                ║
				-- ║ I don't want to restrict the pathmatching to just specifically anime ║
				-- ║ because *maybe* in the future I decide to download some series       ║
				-- ║ into a playlist, and name it in a way where it will work             ║
				-- ║ with this `glaza` integration                                        ║
				-- ║                                                                      ║
				-- ║ But for now this is meant to provide shortcuts for doing `glaza`     ║
				-- ║ commands while watching anime                                        ║
				-- ║ I provide only the 4 main actions that I do the most commonly,       ║
				-- ║ and are related directly to the process of watching a show;          ║
				-- ║ Because executing commands from the environment where I was just     ║
				-- ║ watching the show, makes sense                                       ║
				-- ╚══════════════════════════════════════════════════════════════════════╝
				if require('oil').get_current_dir():gmatch(vim.fn.expand('~/vid/content/')) then
					---@return integer?, integer?
					local function get_minmax_episodes()
						local cur_dir = require('oil').get_current_dir() --[[@as string]]
						local episodes = vim.fn.glob(cur_dir .. '*', true, true)
						local only_numerical = vim.tbl_map(function(path)
							local maybe_episode_number = tonumber(vim.fn.fnamemodify(path, ':t:s;\\..*;;'))
							if not maybe_episode_number then return end
							return maybe_episode_number
						end, episodes)
						if #only_numerical == 0 then
							vim.notify('no episodes')
							return
						end
						table.sort(only_numerical)
						return only_numerical[1], only_numerical[#only_numerical]
					end

					table.insert(options, {
						'episode',
						function()
							local min, _ = get_minmax_episodes()
							if not min then return end
							local output = env.shell({ 'glaza', '-g', 'episode', oil_tail(), min - 1 }):wait()
							vim.notify(output.stderr)
						end,
					})
					table.insert(options, {
						'download',
						function()
							local _, max = get_minmax_episodes()
							if not max then return end
							local output = env.shell({ 'glaza', '-g', 'download', oil_tail(), max }):wait()
							vim.notify(output.stderr)
						end,
					})

					---@param which 'finish'|'drop'
					local function finish_or_drop(which)
						return function()
							local anime_dir = require('oil').get_current_dir() --[[@as string]]
							local output = env.shell({ 'glaza', '-g', which, oil_tail() }):wait()
							require('oil.actions').parent.callback()
							env.shell({ 'rm', '-fr', anime_dir }):wait()
							vim.notify(output.stderr)
						end
					end

					table.insert(options, {
						'finish',
						finish_or_drop('finish'),
					})
					table.insert(options, {
						'drop',
						finish_or_drop('drop'),
					})
				end

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
