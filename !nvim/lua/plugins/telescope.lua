local telescope_opts = function()
	local layout_actions = require('telescope.actions.layout')
	local actions = require('telescope.actions')
	local actions_set = require('telescope.actions.set')
	local actions_state = require('telescope.actions.state')

	local function git_branch_pick(bufnr)
		local branch = actions_state.get_selected_entry().value
		local options = {
			{ 'Switch', function() vim.cmd('Git switch ' .. branch) end },
			{ 'Delete', function() vim.cmd('Git branch -d ' .. branch) end },
			{ 'Copy', function() vim.fn.setreg('+', branch) end },
		}
		local picked = env.confirm(nil, options)
		if not picked then return end
		picked()
		actions.close(bufnr)
	end

	local function git_commits_pick(bufnr)
		local commit_hash = actions_state.get_selected_entry().value
		local options = {
			{ 'View', function() require('gitsigns').show(commit_hash) end },
			{ 'Copy', function() vim.fn.setreg('+', commit_hash) end },
			{
				'P&rior',
				function()
					vim.fn.setreg('+', env.shell({ 'git', 'rev-parse', '--short', commit_hash .. '^' }):wait().stdout:trim())
				end,
			},
		}
		local picked = env.confirm(nil, options)
		if not picked then return end
		actions.close(bufnr)
		picked()
	end

	require('telescope').load_extension('notify')
	require('telescope').load_extension('fzf')
	require('telescope').load_extension('zoxide')
	return {
		defaults = {
			prompt_prefix = '',
			selection_caret = '󱕅 ',
			multi_icon = ' ',
			initial_mode = 'insert',
			results_title = false,
			prompt_title = false,
			wrap_results = true,
			layout_strategy = 'flex',
			sorting_strategy = 'ascending',
			selection_strategy = 'row',
			borderchars = { '━', '┃', '━', '┃', '┏', '┓', '┛', '┗' },
			path_display = function(_, path) return vim.fn.fnamemodify(path, ':~:.') end,
			cycle_layout_list = { 'vertical', 'horizontal' },
			preview = {
				treesitter = true,
				hide_on_startup = true,
			},
			layout_config = {
				height = 0.99,
				width = 0.99,
				preview_cutoff = 5,
				horizontal = {
					preview_width = 0.5,
				},
				vertical = {
					preview_height = 0.6,
				},
			},
			mappings = {
				n = {
					['T'] = 'select_vertical',
					['t'] = 'select_horizontal',
					['Q'] = 'smart_add_to_qflist',
					['q'] = 'smart_send_to_qflist',
					['f'] = layout_actions.toggle_preview,
					['F'] = layout_actions.cycle_layout_next,
					['H'] = 'preview_scrolling_up',
					['L'] = 'preview_scrolling_down',
					['<C-n>'] = 'move_selection_next',
					['<C-p>'] = 'move_selection_previous',
					['J'] = function(bufnr) actions_set.shift_selection(bufnr, 6) end,
					['K'] = function(bufnr) actions_set.shift_selection(bufnr, -6) end,
					['<C-v>'] = false,
					['<C-u>'] = false,
					['<C-d>'] = false,
				},
				i = {
					['<C-v>'] = false,
					['<C-u>'] = false,
					['<C-d>'] = false,
				},
			},
		},
		pickers = {
			find_files = {
				hidden = true,
				no_ignore = false,
				no_ignore_parent = false,
			},
			live_grep = {
				disable_coordinates = true,
				additional_args = { '--hidden' }
			},
			grep_string = {
				initial_mode = 'normal',
				preview = {
					hide_on_startup = false,
				},
				disable_coordinates = true,
				additional_args = { '--hidden' }
			},
			git_commits = {
				mappings = {
					n = {
						['<CR>'] = git_commits_pick,
					},
					i = {
						['<CR>'] = git_commits_pick,
					},
				},
			},
			git_bcommits = {
				mappings = {
					n = {
						['<CR>'] = git_commits_pick,
					},
					i = {
						['<CR>'] = git_commits_pick,
					},
				},
			},
			git_branches = {
				mappings = {
					n = {
						['<CR>'] = git_branch_pick,
					},
					i = {
						['<CR>'] = git_branch_pick,
					},
				},
			},
			command_history = {
				mappings = {
					n = {
						['<CR>'] = 'edit_command_line',
					},
					i = {
						['<CR>'] = 'edit_command_line',
					},
				},
			},
			jumplist = {
				show_line = false,
			},
			loclist = {
				show_line = false,
			},
			git_status = {
				initial_mode = 'normal',
				preview = {
					hide_on_startup = false,
				},
				git_icons = {
					added = '󰐕',
					changed = '',
					deleted = '󰍴',
					renamed = '󰕍',
					untracked = '?',
				},
			},
			buffers = {
				ignore_current_buffer = true,
				sort_lastused = true,
				sort_mru = true,
				initial_mode = 'normal',
				preview = {
					hide_on_startup = false,
				},
			},
			quickfix = {
				show_line = false,
			},
			lsp_references = {
				show_line = false,
				include_declaration = false,
				initial_mode = 'normal',
				preview = {
					hide_on_startup = false,
				},
				layout_config = {
					horizontal = {
						preview_width = 0.7
					},
				},
			},
			lsp_incoming_calls = {
				show_line = false,
			},
			lsp_outgoing_calls = {
				show_line = false,
			},
			lsp_definitions = {
				initial_mode = 'normal',
				preview = {
					hide_on_startup = false,
				},
				show_line = false,
				layout_config = {
					horizontal = {
						preview_width = 0.7
					},
				},
			},
			lsp_type_definitions = {
				show_line = false,
			},
			lsp_implementations = {
				show_line = false,
			},
			oldfiles = {
				initial_mode = 'normal',
				preview = {
					hide_on_startup = false,
				},
			},
		},
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = 'smart_case', -- or 'ignore_case' or 'respect_case' (the default case_mode is 'smart_case')
			},
			zoxide = {
				prompt_title = 'zoxide',
				mappings = {
					default = {
						action = function(selection) vim.cmd.tcd(selection.path) end,
					},
					['<C-s>'] = false,
					['<C-v>'] = false,
					['<C-e>'] = false,
					['<C-b>'] = false,
					['<C-f>'] = false,
					['<C-t>'] = false,
				},
			},
		},
	}
end

---@type LazyPluginSpec[]
return {
	{
		'jvgrootveld/telescope-zoxide',
		lazy = true,
		dependencies = {
			'nvim-lua/popup.nvim',
			'nvim-lua/plenary.nvim',
		},
	},
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-tree/nvim-web-devicons',
			'nvim-treesitter/nvim-treesitter',
			'jvgrootveld/telescope-zoxide',
			'rcarriga/nvim-notify',
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				lazy = true,
				build = 'make',
			},
		},
		cmd = 'Telescope',
		lazy = true,
		opts = telescope_opts,
		config = function(_, opts)
			env.set_high('TelescopeResultsDiffUntracked', { fg = env.color.shell_grey })
			env.set_high('TelescopeResultsDiffDelete', { fg = env.color.shell_red })
			env.set_high('TelescopeResultsDiffChange', { fg = env.color.shell_cyan })
			env.set_high('TelescopeResultsDiffAdd', { fg = env.color.shell_salad })
			env.set_high('TelescopeSelection', { bg = env.color.dark12 })
			env.set_high('TelescopeMatching', { fg = env.color.shell_yellow, bold = true })
			env.set_high('TelescopeSelectionCaret', { fg = env.color.shell_yellow, bg = env.color.dark12, bold = true })
			env.set_high('TelescopeMultiSelection', { link = 'Blue' })

			require('telescope').setup(opts)
		end,
	},
}
