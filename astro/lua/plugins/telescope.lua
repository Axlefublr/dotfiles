local telescope_opts = function(_, opts)
	local layout_actions = require('telescope.actions.layout')
	local actions = require('telescope.actions')
	local actions_set = require('telescope.actions.set')
	local actions_state = require('telescope.actions.state')
	opts.defaults.mappings = nil

	local function open_parent_in_oil(bufnr)
		local selection = actions_state.get_selected_entry().value
		actions.close(bufnr)
		local parent_dir = vim.fn.fnamemodify(selection, ':h')
		require('oil').open(parent_dir)
	end

	return require('astrocore').extend_tbl(opts, {
		defaults = {
			prompt_prefix = '',
			selection_caret = '󱕅 ',
			multi_icon = ' ',
			initial_mode = 'insert',
			results_title = false,
			prompt_title = false,
			wrap_results = true,
			layout_strategy = 'flex',
			selection_strategy = 'row',
			path_display = function(opts, path)
				return vim.fn.fnamemodify(path, ':~:.')
			end,
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
					preview_height = 10,
				},
			},
			mappings = {
				n = {
					['<C-l>'] = 'select_vertical',
					['<F6>'] = 'select_horizontal',
					['<A-u>'] = 'smart_add_to_qflist',
					['<A-U>'] = 'smart_send_to_qflist',
					['<A-i>'] = layout_actions.toggle_preview,
					['H'] = 'preview_scrolling_up',
					['L'] = 'preview_scrolling_down',
					['<C-n>'] = 'move_selection_next',
					['<C-p>'] = 'move_selection_previous',
					['<A-q>'] = open_parent_in_oil,
					['J'] = function(bufnr)
						actions_set.shift_selection(bufnr, 6)
					end,
					['K'] = function(bufnr)
						actions_set.shift_selection(bufnr, -6)
					end,
					['<C-v>'] = false,
					['<C-u>'] = false,
					['<C-d>'] = false,
				},
				i = {
					['<C-l>'] = 'select_vertical',
					['<F6>'] = 'select_horizontal',
					['<A-u>'] = 'smart_add_to_qflist',
					['<A-U>'] = 'smart_send_to_qflist',
					['<A-i>'] = layout_actions.toggle_preview,
					['<A-q>'] = open_parent_in_oil,
					['<C-v>'] = false,
					['<C-u>'] = false,
					['<C-d>'] = false,
				},
			},
		},
		pickers = {
			find_files = {
				hidden = true,
				no_ignore = true,
				no_ignore_parent = true,
			},
			live_grep = {
				disable_coordinates = true,
			},
			grep_string = {
				initial_mode = 'normal',
				preview = {
					hide_on_startup = false,
				},
				disable_coordinates = true,
			},
			git_bcommits = {
				mappings = {
					n = {
						['<A-o>s'] = 'git_checkout_current_buffer',
						['<CR>'] = function(prompt_bufnr)
							local commit_hash = actions_state.get_selected_entry().value
							actions.close(prompt_bufnr)
							require('gitsigns').show(commit_hash)
						end,
					},
					i = {
						['<A-o>s'] = 'git_checkout_current_buffer',
						['<CR>'] = function(prompt_bufnr)
							local commit_hash = actions_state.get_selected_entry().value
							actions.close(prompt_bufnr)
							require('gitsigns').show(commit_hash)
						end,
					},
				},
			},
			git_branches = {
				mappings = {
					n = {
						['<A-o>c'] = 'git_create_branch',
						['<A-o>d'] = 'git_delete_branch',
						['<A-o>m'] = 'git_merge_branch',
						['<A-o>r'] = 'git_rebase_branch',
						['<A-o>s'] = 'git_checkout',
						['<CR>'] = 'git_switch_branch',
					},
					i = {
						['<A-o>c'] = 'git_create_branch',
						['<A-o>d'] = 'git_delete_branch',
						['<A-o>m'] = 'git_merge_branch',
						['<A-o>r'] = 'git_rebase_branch',
						['<A-o>s'] = 'git_checkout',
						['<CR>'] = 'git_switch_branch',
					},
				},
			},
			command_history = {
				mappings = {
					n = {
						['<A-o>e'] = 'edit_command_line',
					},
					i = {
						['<A-o>e'] = 'edit_command_line',
					},
				},
			},
			jumplist = {
				show_line = false,
			},
			loclist = {
				show_line = false,
			},
			git_files = {
				show_untracked = true,
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
			},
			lsp_incoming_calls = {
				show_line = false,
			},
			lsp_outgoing_calls = {
				show_line = false,
			},
			lsp_definitions = {
				show_line = false,
			},
			lsp_type_definitions = {
				show_line = false,
			},
			lsp_implementations = {
				show_line = false,
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
	})
end

---@type LazySpec
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
			'kyazdani42/nvim-web-devicons',
			'jvgrootveld/telescope-zoxide',
		},
		lazy = true,
		opts = telescope_opts,
	},
}
