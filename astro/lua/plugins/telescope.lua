local function remaps(telescope)
	local builtin = require('telescope.builtin')

	local extra = {
		'~/t',
		'~/prog/noties',
		'~/.local/share/alien_temple',
		'~/.local/share/glaza',
	}

	vim.keymap.set('n', '<Leader>ja', builtin.find_files)
	vim.keymap.set('n', '<Leader>jA', function()
		builtin.find_files({
			search_dirs = extra,
		})
	end)

	vim.keymap.set(
		'n',
		'<Leader>jf',
		function()
			builtin.find_files({
				hidden = false,
				no_ignore = false,
				no_ignore_parent = false,
			})
		end
	)
	vim.keymap.set(
		'n',
		'<Leader>jF',
		function()
			builtin.find_files({
				hidden = false,
				no_ignore = false,
				no_ignore_parent = false,
				search_dirs = extra,
			})
		end
	)

	vim.keymap.set('n', '<Leader>jd', builtin.live_grep)
	vim.keymap.set('n', '<Leader>jD', function()
		builtin.live_grep({
			search_dirs = extra,
		})
	end)

	vim.keymap.set(
		'n',
		'<Leader>jg',
		function()
			builtin.live_grep({
				additional_args = {
					'--no-ignore',
					'--hidden',
				},
			})
		end
	)
	vim.keymap.set(
		'n',
		'<Leader>jG',
		function()
			builtin.live_grep({
				search_dirs = extra,
				additional_args = {
					'--no-ignore',
					'--hidden',
				},
			})
		end
	)

	vim.keymap.set('n', '<Leader>jr', builtin.grep_string)
	vim.keymap.set(
		'n',
		'<Leader>jt',
		function()
			builtin.grep_string({
				additional_args = {
					'--no-ignore',
					'--hidden',
				},
			})
		end
	)

	vim.keymap.set('x', '<Leader>jr', function()
		local previous_clipboard = vim.fn.getreg('+')
		FeedKeys('y')
		vim.schedule(function()
			builtin.grep_string({
				search = vim.fn.getreg('+'),
			})
			vim.fn.setreg('+', previous_clipboard)
		end)
	end)
	vim.keymap.set('x', '<Leader>jt', function()
		local previous_clipboard = vim.fn.getreg('+')
		FeedKeys('y')
		vim.schedule(function()
			builtin.grep_string({
				search = vim.fn.getreg('+'),
				additional_args = {
					'--no-ignore',
					'--hidden',
				},
			})
			vim.fn.setreg('+', previous_clipboard)
		end)
	end)

	vim.keymap.set('n', '<Leader>jh', builtin.help_tags)
	vim.keymap.set('n', '<Leader>js', builtin.current_buffer_fuzzy_find)
	vim.keymap.set('n', '<Leader>jc', builtin.git_commits)
	vim.keymap.set('n', '<Leader>jC', builtin.git_bcommits)
	vim.keymap.set('n', '<Leader>jx', builtin.git_branches)
	vim.keymap.set('n', '<Leader>je', builtin.git_status)
	vim.keymap.set('n', '<Leader>j\\', builtin.builtin)
	vim.keymap.set('n', '<Leader>jw', builtin.buffers)
	vim.keymap.set('n', '<Leader>jW', builtin.oldfiles)
	vim.keymap.set('n', '<Leader><CR>', builtin.command_history)
	vim.keymap.set('n', '<Leader>jm', builtin.man_pages)
	vim.keymap.set('n', '<Leader>ji', builtin.marks)
	vim.keymap.set('n', '<Leader>jH', builtin.highlights)
	vim.keymap.set('n', '<Leader>j;', builtin.filetypes)
	vim.keymap.set('n', '<Leader>jq', function() builtin.diagnostics({ bufnr = 0 }) end)
	vim.keymap.set('n', '<Leader>jQ', builtin.diagnostics)
	vim.keymap.set('n', '<Leader>jj', builtin.quickfix)

	vim.keymap.set('n', 'gD', builtin.lsp_references)
	vim.keymap.set('n', '<Leader>li', builtin.lsp_incoming_calls)
	vim.keymap.set('n', '<Leader>lo', builtin.lsp_outgoing_calls)
	vim.keymap.set('n', 'gd', builtin.lsp_definitions)
	vim.keymap.set('n', '<Leader>lt', builtin.lsp_type_definitions)
	vim.keymap.set('n', '<Leader>lm', builtin.lsp_implementations)
	vim.keymap.set('n', '<Leader>ls', builtin.lsp_document_symbols)
	vim.keymap.set('n', '<Leader>lS', builtin.lsp_workspace_symbols)

	vim.keymap.set('n', '<Leader>jz', telescope.extensions.zoxide.list)
	vim.keymap.set('n', '<Leader>jn', telescope.extensions.notify.notify)
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
		keys = {
			{ '<Leader>j', mode = { 'n', 'x' } },
			{ '<Leader>l' },
			{ 'gd' },
			{ 'gD' },
			{ '<Leader><CR>' },
		},
		opts = function(_, opts)
			local layout_actions = require('telescope.actions.layout')
			local actions = require('telescope.actions')
			local actions_state = require('telescope.actions.state')
			opts.defaults.mappings = nil
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
		end,
		config = function(plugin, opts)
			require('astronvim.plugins.configs.telescope')(plugin, opts)
			local telescope = require('telescope')
			remaps(telescope)
		end,
	},
}
