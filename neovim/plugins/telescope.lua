local function remaps(telescope)
	local builtin = require('telescope.builtin')

	vim.keymap.set('n', ',ja', builtin.find_files, {})
	vim.keymap.set(
		'n',
		',Ja',
		function()
			builtin.find_files({
				search_dirs = {
					'~',
				},
			})
		end,
		{}
	)
	vim.keymap.set(
		'n',
		',jA',
		function()
			builtin.find_files({
				search_dirs = {
					'~/prog/dotfiles',
					'~/prog/noties',
					'~/prog/job',
					'~/prog/backup',
					'~/.local/share/alien_temple',
					'~/.local/share/glaza',
					'~/.local/share/magazine',
				},
			})
		end
	)

	vim.keymap.set(
		'n',
		',jf',
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
		',Jf',
		function()
			builtin.find_files({
				search_dirs = {
					'~',
				},
				hidden = false,
				no_ignore = false,
				no_ignore_parent = false,
			})
		end
	)
	vim.keymap.set(
		'n',
		',jF',
		function()
			builtin.find_files({
				hidden = false,
				no_ignore = false,
				no_ignore_parent = false,
				search_dirs = {
					'~/prog/dotfiles',
					'~/prog/noties',
					'~/prog/job',
					'~/prog/backup',
					'~/.local/share/alien_temple',
					'~/.local/share/glaza',
					'~/.local/share/magazine',
				},
			})
		end
	)

	vim.keymap.set('n', ',jd', builtin.live_grep, {})
	vim.keymap.set(
		'n',
		',Jd',
		function()
			builtin.live_grep({
				search_dirs = {
					'~',
				},
			})
		end
	)
	vim.keymap.set('n', ',jD', function()
		builtin.live_grep({
			search_dirs = {
				'~/prog/dotfiles',
				-- '~/prog/noties',
				-- '~/prog/job',
				'~/prog/backup',
				-- '~/.local/share/alien_temple',
				-- '~/.local/share/glaza',
				-- '~/.local/share/magazine',
			},
		})
	end)

	vim.keymap.set(
		'n',
		',jg',
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
		',Jg',
		function()
			builtin.live_grep({
				search_dirs = {
					'~',
				},
				additional_args = {
					'--no-ignore',
					'--hidden',
				},
			})
		end
	)
	vim.keymap.set('n', ',jG', function()
		builtin.live_grep({
			search_dirs = {
				'~/prog/dotfiles',
				-- '~/prog/noties',
				-- '~/prog/job',
				'~/prog/backup',
				-- '~/.local/share/alien_temple',
				-- '~/.local/share/glaza',
				-- '~/.local/share/magazine',
			},
			additional_args = {
				'--no-ignore',
				'--hidden',
			},
		})
	end)

	vim.keymap.set('n', ',jh', builtin.help_tags, {})
	vim.keymap.set('n', ',jt', builtin.treesitter, {})
	vim.keymap.set('n', ',js', builtin.current_buffer_fuzzy_find, {})
	vim.keymap.set('n', ',jc', builtin.git_bcommits, {})
	vim.keymap.set('n', ',jx', builtin.git_branches, {})
	vim.keymap.set('n', ',je', builtin.git_status, {})
	vim.keymap.set('n', ',jr', builtin.git_stash, {})
	vim.keymap.set('n', ',j\\', builtin.builtin, {})
	vim.keymap.set('n', ',jk', builtin.buffers, {})
	vim.keymap.set('n', ',jK', builtin.oldfiles, {})
	vim.keymap.set('n', ',j<cr>', builtin.commands, {})
	vim.keymap.set('n', ',jy', builtin.command_history, {})
	vim.keymap.set('n', ',jm', builtin.man_pages, {})
	vim.keymap.set('n', ',ji', builtin.marks, {})
	vim.keymap.set('n', ',jo', builtin.jumplist, {})
	vim.keymap.set('n', ",j'", builtin.registers, {})
	vim.keymap.set('n', ',jH', builtin.highlights, {})
	vim.keymap.set('n', ',j;', builtin.filetypes, {})
	vim.keymap.set('n', ',jq', function() builtin.diagnostics({ bufnr = 0 }) end, {})
	vim.keymap.set('n', ',jQ', builtin.diagnostics, {})
	vim.keymap.set('n', ',jj', builtin.quickfix, {})

	vim.keymap.set('n', ',lr', builtin.lsp_references, {})
	vim.keymap.set('n', ',li', builtin.lsp_incoming_calls, {})
	vim.keymap.set('n', ',lo', builtin.lsp_outgoing_calls, {})
	vim.keymap.set('n', ',ld', builtin.lsp_definitions, {})
	vim.keymap.set('n', ',lt', builtin.lsp_type_definitions, {})
	vim.keymap.set('n', ',lm', builtin.lsp_implementations, {})
	vim.keymap.set('n', ',ls', builtin.lsp_document_symbols, {})
	vim.keymap.set('n', ',lS', builtin.lsp_workspace_symbols, {})

	vim.keymap.set('n', ',jz', telescope.extensions.zoxide.list, {})
end

return {
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'make',
		lazy = true,
	},
	{
		'jvgrootveld/telescope-zoxide',
		lazy = true,
		dependencies = {
			'nvim-lua/popup.nvim',
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope.nvim',
		},
	},
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons' },
		keys = {
			{ ',j' },
			{ ',l' },
		},
		config = function()
			local telescope = require('telescope')
			local layout_actions = require('telescope.actions.layout')
			telescope.setup({
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
							['<c-l>'] = 'select_vertical',
							['<f6>'] = 'select_horizontal',
							['<a-u>'] = 'smart_add_to_qflist',
							['<a-U>'] = 'smart_send_to_qflist',
							['<a-i>'] = layout_actions.toggle_preview,
							['H'] = 'preview_scrolling_up',
							['L'] = 'preview_scrolling_down',
							['<c-n>'] = 'move_selection_next',
							['<c-p>'] = 'move_selection_previous',
							['<c-d>'] = 'move_to_bottom',
							['<c-u>'] = 'move_to_top',
							['<c-v>'] = false,
						},
						i = {
							['<c-l>'] = 'select_vertical',
							['<f6>'] = 'select_horizontal',
							['<a-u>'] = 'smart_add_to_qflist',
							['<a-U>'] = 'smart_send_to_qflist',
							['<a-i>'] = layout_actions.toggle_preview,
							['<c-v>'] = false,
							['<c-d>'] = 'move_to_bottom',
							['<c-u>'] = 'move_to_top',
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
						-- additional_args = {}
					},
					git_branches = {
						mappings = {
							n = {
								[',c'] = 'git_create_branch',
								[',d'] = 'git_delete_branch',
								[',m'] = 'git_merge_branch',
								[',r'] = 'git_rebase_branch',
								[',s'] = 'git_switch_branch',
							},
						},
					},
					command_history = {
						mappings = {
							n = {
								[',e'] = 'edit_command_line',
							},
						},
					},
					jumplist = {
						show_line = false,
					},
					registers = {
						mappings = {
							n = {
								[',e'] = 'edit_register',
							},
						},
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
							added = '',
							changed = '󰻖',
							deleted = '',
							renamed = '󰈷',
							untracked = '󰛢',
						},
					},
					buffers = {
						ignore_current_buffer = false,
						sort_lastused = true,
						sort_mru = true,
					},
					quickfix = {
						show_line = false,
					},
					lsp_references = {
						show_line = false,
						include_declaration = false,
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
							['<c-s>'] = false,
							['<c-v>'] = false,
							['<c-e>'] = false,
							['<c-b>'] = false,
							['<c-f>'] = false,
							['<c-t>'] = false,
						},
					},
				},
			})

			telescope.load_extension('fzf')
			telescope.load_extension('zoxide')

			vim.api.nvim_set_hl(0, 'TelescopeResultsDiffUntracked', { fg = Colors.shell_grey })
			vim.api.nvim_set_hl(0, 'TelescopeResultsDiffDelete', { fg = Colors.shell_red })
			vim.api.nvim_set_hl(0, 'TelescopeResultsDiffChange', { fg = Colors.shell_cyan })
			vim.api.nvim_set_hl(0, 'TelescopeSelection', { bg = Colors.darkerest })
			vim.api.nvim_set_hl(0, 'TelescopeMatching', { fg = Colors.shell_yellow, bold = true })
			vim.api.nvim_set_hl(0, 'TelescopeSelectionCaret', { fg = Colors.shell_yellow, bg = Colors.darkerest })

			remaps(telescope)
		end,
	},
}
