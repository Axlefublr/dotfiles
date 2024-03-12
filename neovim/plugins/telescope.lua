return {
	'nvim-lua/popup.nvim',
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'make',
	},
	{
		'jvgrootveld/telescope-zoxide',
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
		opts = {
			defaults = {
				prompt_prefix = '',
				selection_caret = '󱕅 ',
				multi_icon = ' ',
				initial_mode = 'insert',
				results_title = false,
				prompt_title = false,
				wrap_results = true,
				layout_strategy = 'flex',
				layout_config = {
					height = 0.99,
					width = 0.99,
					preview_cutoff = 5,
					horizontal = {
						preview_width = 50,
					},
					vertical = {
						preview_height = 10,
					},
				},
				mappings = {
					n = {
						['<a-f>'] = 'select_horizontal',
						['<a-s>'] = 'select_vertical',
						['H'] = 'preview_scrolling_up',
						['L'] = 'preview_scrolling_down',
					},
					i = {
						['<a-f>'] = 'select_horizontal',
						['<a-s>'] = 'select_vertical',
						['<c-u>'] = false,
					},
				},
			},
			pickers = {
				find_files = {
					hidden = true,
				},
				git_branches = {
					mappings = {
						n = {
							[',c'] = 'git_create_branch',
							[',d'] = 'git_delete_branch',
							[',m'] = 'git_merge_branch',
							[',r'] = 'git_rebase_branch',
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
					show_untracked = true
				},
				buffers = {
					ignore_current_buffer = true,
					sort_lastused = true,
					sort_mru = true
				},
				lsp_references = {
					show_line = false,
					include_declaration = false
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
						['<c-s>'] = false,
						['<c-v>'] = false,
						['<c-e>'] = false,
						['<c-b>'] = false,
						['<c-f>'] = false,
						['<c-t>'] = false,
					},
				},
			},
		},
		init = function()
			require('telescope').load_extension('fzf')
			require('telescope').load_extension('zoxide')
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', ',jf', builtin.find_files, {})
			vim.keymap.set(
				'n',
				',jF',
				'<cmd>lua require("telescope.builtin").find_files({'
					.. 'hidden = true,'
					.. 'search_dirs = {'
					.. '"~/prog/dotfiles",'
					.. '"~/prog/noties",'
					.. '"~/prog/job",'
					.. '"~/.local/share/alien_temple",'
					.. '"~/.local/share/floral_barrel",'
					.. '}'
					.. '})<cr>',
				{}
			)
			vim.keymap.set('n', ',jd', builtin.live_grep, {})
			vim.keymap.set(
				'n',
				',jD',
				'<cmd>lua require("telescope.builtin").live_grep({'
					.. 'search_dirs = {'
					.. '"~/prog/dotfiles",'
					.. '"~/prog/noties",'
					.. '"~/prog/job",'
					.. '"~/.local/share/alien_temple",'
					.. '"~/.local/share/floral_barrel",'
					.. '}'
					.. '})<cr>',
				{}
			)
			vim.keymap.set('n', ',jh', builtin.help_tags, {})
			vim.keymap.set('n', ',jt', builtin.treesitter, {})
			vim.keymap.set('n', ',js', builtin.current_buffer_fuzzy_find, {})
			vim.keymap.set('n', ',jc', builtin.git_bcommits, {})
			vim.keymap.set('n', ',jx', builtin.git_branches, {})
			vim.keymap.set('n', ',je', builtin.git_status, {})
			vim.keymap.set('n', ',jr', builtin.git_stash, {})
			vim.keymap.set('n', ',j\\', builtin.builtin, {})
			vim.keymap.set('n', ',ja', builtin.buffers, {})
			vim.keymap.set('n', ',jA', builtin.oldfiles, {})
			vim.keymap.set('n', ',j<cr>', builtin.commands, {})
			vim.keymap.set('n', ',jy', builtin.command_history, {})
			vim.keymap.set('n', ',jm', builtin.man_pages, {})
			vim.keymap.set('n', ',jl', builtin.marks, {})
			vim.keymap.set('n', ',jo', builtin.jumplist, {})
			vim.keymap.set('n', ",j'", builtin.registers, {})
			vim.keymap.set('n', ',jH', builtin.highlights, {})
			vim.keymap.set('n', ',j;', builtin.filetypes, {})
			vim.keymap.set('n', ',jq', function() builtin.diagnostics({ bufnr = 0 }) end, {})
			vim.keymap.set('n', ',jQ', builtin.diagnostics, {})
			vim.keymap.set('n', ',jj', builtin.git_files, {})

			vim.keymap.set('n', ',lr', builtin.lsp_references, {})
			vim.keymap.set('n', ',li', builtin.lsp_incoming_calls, {})
			vim.keymap.set('n', ',lo', builtin.lsp_outgoing_calls, {})
			vim.keymap.set('n', ',ld', builtin.lsp_definitions, {})
			vim.keymap.set('n', ',lt', builtin.lsp_type_definitions, {})
			vim.keymap.set('n', ',lm', builtin.lsp_implementations, {})
			vim.keymap.set('n', ',ll', builtin.lsp_document_symbols, {})
			vim.keymap.set('n', ',lL', builtin.lsp_workspace_symbols, {})

			vim.keymap.set('n', ',jz', require('telescope').extensions.zoxide.list, {})
		end,
	},
}
