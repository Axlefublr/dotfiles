vim.cmd('packadd! matchit')

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	'kana/vim-textobj-user',
	'tpope/vim-repeat',
	'adelarsq/vim-matchit',
	'nvim-lua/plenary.nvim',
	'farmergreg/vim-lastplace',
	'xiyaowong/transparent.nvim',
	'kyazdani42/nvim-web-devicons',
	{
		'wellle/targets.vim',
		init = function() vim.g.targets_nl = 'nh' end,
	},
	{
		'vim-scripts/ReplaceWithRegister',
		config = function() vim.keymap.set('n', 'grr', '<Plug>ReplaceWithRegisterLine') end,
	},
	{
		'junegunn/vim-easy-align',
		config = function() vim.keymap.set('', 'ga', '<Plug>(EasyAlign)') end,
	},
	{
		'sainnhe/gruvbox-material',
		config = function() vim.cmd.colorscheme('gruvbox-material') end,
	},
	{
		'bkad/CamelCaseMotion',
		init = function() vim.g.camelcasemotion_key = '<leader>' end,
	},
	{
		'kylechui/nvim-surround',
		version = '*',
		event = 'VeryLazy',
		config = true,
	},
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'make',
	},
	{
		'nvim-treesitter/nvim-treesitter',
		main = 'nvim-treesitter.configs',
		build = ':TSUpdate',
		opts = {
			ensure_installed = {
				'lua',
				'rust',
				'fish',
				'rasi',
				'c',
				'vim',
				'vimdoc',
				'query',
				'c_sharp',
				'css',
				'diff',
				'gitcommit',
				'gitignore',
				'html',
				'json',
				'jsonc',
				'markdown',
				'toml',
				'xcompose',
				'yaml',
			},
			auto_install = true,

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = ',ds',
					scope_incremental = ',dc',
					node_incremental = '<a-]>',
					node_decremental = '<a-[>',
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					include_surrounding_whitespace = false,
					keymaps = {
						['af'] = '@function.outer',
						['if'] = '@function.inner',
						['is'] = '@assignment.inner',
						['as'] = '@assignment.outer',
						['ig'] = '@block.inner',
						['ag'] = '@block.outer',
						['ia'] = '@parameter.inner',
						['aa'] = '@parameter.outer',
						['ic'] = '@call.inner',
						['ac'] = '@call.outer',
						['i/'] = '@comment.inner',
						['a/'] = '@comment.outer',
						['ir'] = '@conditional.inner',
						['ar'] = '@conditional.outer',
						['io'] = '@loop.inner',
						['ao'] = '@loop.outer',
						['it'] = '@return.inner',
						['at'] = '@return.outer',
					},
					selection_modes = {
						-- ['@function.outer'] = '<c-v>'
					},
				},
				swap = {
					enable = true,
					swap_next = {
						[']]f'] = '@function.inner',
						[']]F'] = '@function.outer',
						[']]s'] = '@assignment.inner',
						[']]S'] = '@assignment.outer',
						[']]g'] = '@block.inner',
						[']]G'] = '@block.outer',
						[']]A'] = '@parameter.outer',
						[']]a'] = '@parameter.inner',
						[']]c'] = '@call.inner',
						[']]C'] = '@call.outer',
						[']]/'] = '@comment.inner',
						[']]?'] = '@comment.outer',
						[']]r'] = '@conditional.inner',
						[']]R'] = '@conditional.outer',
						[']]o'] = '@loop.inner',
						[']]O'] = '@loop.outer',
						[']]t'] = '@return.inner',
						[']]T'] = '@return.outer',
					},
					swap_previous = {
						['[[f'] = '@function.inner',
						['[[F'] = '@function.outer',
						['[[s'] = '@assignment.inner',
						['[[S'] = '@assignment.outer',
						['[[g'] = '@block.inner',
						['[[G'] = '@block.outer',
						['[[a'] = '@parameter.inner',
						['[[A'] = '@parameter.outer',
						['[[c'] = '@call.inner',
						['[[C'] = '@call.outer',
						['[[/'] = '@comment.inner',
						['[[?'] = '@comment.outer',
						['[[r'] = '@conditional.inner',
						['[[R'] = '@conditional.outer',
						['[[o'] = '@loop.inner',
						['[[O'] = '@loop.outer',
						['[[t'] = '@return.inner',
						['[[T'] = '@return.outer',
					},
				},
				move = {
					enable = true,
					set_jumps = false,
					goto_next_start = {
						[']f'] = '@function.outer',
						[']s'] = '@assignment.inner',
						[']g'] = '@block.outer',
						[']a'] = '@parameter.outer',
						[']c'] = '@call.outer',
						[']/'] = '@comment.outer',
						[']r'] = '@conditional.outer',
						[']o'] = '@loop.outer',
						[']t'] = '@return.outer',
					},
					goto_next_end = {
						[']F'] = '@function.outer',
						[']S'] = '@assignment.inner',
						[']G'] = '@block.outer',
						[']A'] = '@parameter.outer',
						[']C'] = '@call.outer',
						[']?'] = '@comment.outer',
						[']R'] = '@conditional.outer',
						[']O'] = '@loop.outer',
						[']T'] = '@return.outer',
					},
					goto_previous_start = {
						['[f'] = '@function.outer',
						['[s'] = '@assignment.inner',
						['[g'] = '@block.outer',
						['[a'] = '@parameter.outer',
						['[c'] = '@call.outer',
						['[/'] = '@comment.outer',
						['[r'] = '@conditional.outer',
						['[o'] = '@loop.outer',
						['[t'] = '@return.outer',
					},
					goto_previous_end = {
						['[F'] = '@function.outer',
						['[S'] = '@assignment.inner',
						['[G'] = '@block.outer',
						['[A'] = '@parameter.outer',
						['[C'] = '@call.outer',
						['[?'] = '@comment.outer',
						['[R'] = '@conditional.outer',
						['[O'] = '@loop.outer',
						['[T'] = '@return.outer',
					},
				},
			},
		},
		init = function()
			vim.opt.foldmethod = 'expr'
			vim.cmd([[set foldexpr=nvim_treesitter#foldexpr()]])
			vim.opt.foldenable = false
			require('nvim-treesitter.install').prefer_git = true
			local ts_repeat_move = require('nvim-treesitter.textobjects.repeatable_move')
			vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
			vim.keymap.set({ 'n', 'x', 'o' }, ':', ts_repeat_move.repeat_last_move_opposite)
			vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f)
			vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F)
			vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t)
			vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T)
		end,
	},
	{
		'nvim-treesitter/nvim-treesitter-textobjects',
		dependencies = 'nvim-treesitter',
	},
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons' },
		opts = {
			defaults = {
				prompt_prefix = '󱕅 ',
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
				},
				mappings = {
					n = {
						[',aj'] = 'select_horizontal',
						[',al'] = 'select_vertical',
						['H'] = 'preview_scrolling_up',
						['L'] = 'preview_scrolling_down',
					},
					i = {
						['<c-u>'] = false,
						['<a-h>'] = 'close',
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
				lsp_references = {
					show_line = false,
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
			},
		},
		init = function()
			require('telescope').load_extension('fzf')
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
					.. '"~/prog/info",'
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
					.. '"~/prog/info",'
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
			vim.keymap.set('n', ',jY', builtin.filetypes, {})
			vim.keymap.set('n', ',j;', builtin.reloader, {})
			vim.keymap.set('n', ',jq', function() builtin.diagnostics({ bufnr = 0 }) end, {})
			vim.keymap.set('n', ',jQ', builtin.diagnostics, {})

			vim.keymap.set('n', ',lr', builtin.lsp_references, {})
			vim.keymap.set('n', ',li', builtin.lsp_incoming_calls, {})
			vim.keymap.set('n', ',lo', builtin.lsp_outgoing_calls, {})
			vim.keymap.set('n', ',ld', builtin.lsp_definitions, {})
			vim.keymap.set('n', ',lt', builtin.lsp_type_definitions, {})
			vim.keymap.set('n', ',lm', builtin.lsp_implementations, {})
			vim.keymap.set('n', ',ll', builtin.lsp_document_symbols, {})
			vim.keymap.set('n', ',lL', builtin.lsp_workspace_symbols, {})
		end,
	},
	{
		'ggandor/leap.nvim',
		opts = {
			case_sensitive = false,
			max_phase_one_targets = 1,
			equivalence_classes = {
				' \t\n\r',
				'qй',
				'wц',
				'eу',
				'rк',
				'tе',
				'yн',
				'uг',
				'iш',
				'oщ',
				'pз',
				'[х',
				']ъ',
				'aф',
				'sы',
				'dв',
				'fа',
				'gп',
				'hр',
				'jо',
				'kл',
				'lд',
				';ж',
				"'э",
				'zя',
				'xч',
				'cс',
				'vм',
				'bи',
				'nт',
				'mь',
				',б',
				'.ю',
			},
			labels = {
				'f',
				'j',
				'd',
				'k',
				's',
				'l',
				'a',
				'e',
				'i',
				'w',
				'o',
				'g',
				'h',
				'r',
				'u',
				'x',
				'c',
				'z',
				'/',
				'v',
				'm',
				't',
				'y',
				'q',
				'p',
			},
			safe_labels = {},
		},
		init = function()
			vim.keymap.set({ 'n', 'x', 'o' }, 'q', '<Plug>(leap-forward-to)')
			vim.keymap.set({ 'n', 'x', 'o' }, 'Q', '<Plug>(leap-backward-to)')
			vim.keymap.set({ 'n', 'x', 'o' }, ',q', '<Plug>(leap-forward-till)')
			vim.keymap.set({ 'n', 'x', 'o' }, ',Q', '<Plug>(leap-backward-till)')
		end,
	},
	{
		'monaqa/dial.nvim',
		config = function()
			local augend = require('dial.augend')
			require('dial.config').augends:register_group({
				default = {
					augend.integer.alias.decimal_int,
					augend.integer.alias.hex,
					augend.integer.alias.octal,
					augend.integer.alias.binary,
					augend.hexcolor.new({
						case = 'upper',
					}),
					augend.semver.alias.semver,
					augend.date.new({
						pattern = '%y.%m.%d',
						default_kind = 'day',
						only_valid = true,
					}),
					augend.date.alias['%H:%M'],
					augend.date.new({
						pattern = '%B', -- titlecased month names
						default_kind = 'day',
					}),
					augend.constant.new({
						elements = {
							'january',
							'february',
							'march',
							'april',
							'may',
							'june',
							'july',
							'august',
							'september',
							'october',
							'november',
							'december',
						},
						word = true,
						cyclic = true,
					}),
					augend.constant.new({
						elements = {
							'Monday',
							'Tuesday',
							'Wednesday',
							'Thursday',
							'Friday',
							'Saturday',
							'Sunday',
						},
						word = true,
						cyclic = true,
					}),
					augend.constant.new({
						elements = {
							'monday',
							'tuesday',
							'wednesday',
							'thursday',
							'friday',
							'saturday',
							'sunday',
						},
						word = true,
						cyclic = true,
					}),
				},
				toggles = {
					augend.constant.alias.bool,
					augend.constant.new({
						elements = { 'and', 'or' },
						word = true, -- if false, 'sand' is incremented into 'sor', 'doctor' into 'doctand', etc.
						cyclic = true,
					}),
					augend.constant.new({
						elements = { 'AND', 'OR' },
						word = true,
						cyclic = true,
					}),
					augend.constant.new({
						elements = { '&&', '||' },
						word = false,
						cyclic = true,
					}),
					augend.constant.new({
						elements = { 'yes', 'no' },
						word = false,
						cyclic = true,
					}),
				},
				visual = {
					augend.integer.alias.decimal_int,
					augend.integer.alias.hex,
					augend.integer.alias.octal,
					augend.constant.alias.alpha,
					augend.constant.alias.Alpha,
				},
			})

			vim.keymap.set(
				'n',
				'<C-a>',
				function() require('dial.map').manipulate('increment', 'normal') end
			)
			vim.keymap.set(
				'n',
				'<C-x>',
				function() require('dial.map').manipulate('decrement', 'normal') end
			)
			vim.keymap.set(
				'n',
				'g<C-a>',
				function() require('dial.map').manipulate('increment', 'gnormal') end
			)
			vim.keymap.set(
				'n',
				'g<C-x>',
				function() require('dial.map').manipulate('decrement', 'gnormal') end
			)

			vim.keymap.set(
				'v',
				'<c-a>',
				require('dial.map').inc_visual('visual'),
				{ noremap = true }
			)
			vim.keymap.set(
				'v',
				'<c-x>',
				require('dial.map').dec_visual('visual'),
				{ noremap = true }
			)
			vim.keymap.set(
				'v',
				'g<c-a>',
				require('dial.map').inc_gvisual('visual'),
				{ noremap = true }
			)
			vim.keymap.set(
				'v',
				'g<c-x>',
				require('dial.map').dec_visual('visual'),
				{ noremap = true }
			)

			vim.keymap.set(
				'n',
				',dj',
				require('dial.map').inc_normal('toggles'),
				{ noremap = true }
			)
			vim.keymap.set(
				'v',
				',dj',
				require('dial.map').inc_visual('toggles'),
				{ noremap = true }
			)
		end,
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'kyazdani42/nvim-web-devicons' },
		config = function()
			require('lualine').setup({
				options = {
					icons_enabled = true,
					theme = 'auto',
					component_separators = { left = '', right = '' },
					section_separators = { left = '', right = '' },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = false,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					},
				},
				sections = {
					lualine_a = { 'mode' },
					lualine_b = { 'branch', 'diff', 'diagnostics' },
					lualine_c = { 'filename' },
					lualine_x = { 'encoding', 'fileformat', 'filetype' },
					lualine_y = { 'progress' },
					lualine_z = { 'location' },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { 'filename' },
					lualine_x = { 'location' },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = {},
			})
		end,
	},
	{
		'chrisgrieser/nvim-various-textobjs',
		config = function()
			require('various-textobjs').setup({
				-- lines to seek forwards for 'small' textobjs (mostly characterwise textobjs)
				-- set to 0 to only look in the current line
				lookForwardSmall = 2,
				-- lines to seek forwards for 'big' textobjs (mostly linewise textobjs)
				lookForwardBig = 0,
				-- use suggested keymaps (see overview table in README)
				useDefaultKeymaps = false,
			})
			vim.keymap.set(
				{ 'o', 'x' },
				'ii',
				'<cmd>lua require("various-textobjs").indentation(true, true)<CR>'
			)
			vim.keymap.set(
				{ 'o', 'x' },
				'ai',
				'<cmd>lua require("various-textobjs").indentation(false, true)<CR>'
			)
			vim.keymap.set(
				{ 'o', 'x' },
				'iI',
				'<cmd>lua require("various-textobjs").indentation(true, true)<CR>'
			)
			vim.keymap.set(
				{ 'o', 'x' },
				'aI',
				'<cmd>lua require("various-textobjs").indentation(false, false)<CR>'
			)

			vim.keymap.set(
				{ 'o', 'x' },
				'R',
				'<cmd>lua require("various-textobjs").restOfIndentation()<CR>'
			)

			vim.keymap.set(
				{ 'o', 'x' },
				'iS',
				'<cmd>lua require("various-textobjs").subword(true)<CR>'
			)
			vim.keymap.set(
				{ 'o', 'x' },
				'aS',
				'<cmd>lua require("various-textobjs").subword(false)<CR>'
			)

			vim.keymap.set(
				{ 'o', 'x' },
				'ie',
				'<cmd>lua require("various-textobjs").entireBuffer()<CR>'
			)

			vim.keymap.set({ 'o', 'x' }, '.', '<cmd>lua require("various-textobjs").nearEoL()<CR>')

			vim.keymap.set(
				{ 'o', 'x' },
				'iv',
				'<cmd>lua require("various-textobjs").value(true)<CR>'
			)
			vim.keymap.set(
				{ 'o', 'x' },
				'av',
				'<cmd>lua require("various-textobjs").value(false)<CR>'
			)

			vim.keymap.set({ 'o', 'x' }, 'ik', '<cmd>lua require("various-textobjs").key(true)<CR>')
			vim.keymap.set(
				{ 'o', 'x' },
				'ak',
				'<cmd>lua require("various-textobjs").key(false)<CR>'
			)

			vim.keymap.set(
				{ 'o', 'x' },
				'iu',
				'<cmd>lua require("various-textobjs").number(true)<CR>'
			)
			vim.keymap.set(
				{ 'o', 'x' },
				'au',
				'<cmd>lua require("various-textobjs").number(false)<CR>'
			)

			vim.keymap.set({ 'o', 'x' }, 'gl', '<cmd>lua require("various-textobjs").url()<CR>')

			vim.keymap.set(
				{ 'o', 'x' },
				'il',
				'<cmd>lua require("various-textobjs").lineCharacterwise(true)<CR>'
			)
			vim.keymap.set(
				{ 'o', 'x' },
				'al',
				'<cmd>lua require("various-textobjs").lineCharacterwise(false)<CR>'
			)

			vim.keymap.set(
				{ 'o', 'x' },
				'iC',
				'<cmd>lua require("various-textobjs").mdFencedCodeBlock(true)<CR>'
			)
			vim.keymap.set(
				{ 'o', 'x' },
				'aC',
				'<cmd>lua require("various-textobjs").mdFencedCodeBlock(false)<CR>'
			)

			vim.keymap.set(
				{ 'o', 'x' },
				'ix',
				'<cmd>lua require("various-textobjs").htmlAttribute(true)<CR>'
			)
			vim.keymap.set(
				{ 'o', 'x' },
				'ax',
				'<cmd>lua require("various-textobjs").htmlAttribute(false)<CR>'
			)

			vim.keymap.set(
				{ 'o', 'x' },
				'i|',
				'<cmd>lua require("various-textobjs").shellPipe(true)<CR>'
			)
			vim.keymap.set(
				{ 'o', 'x' },
				'a|',
				'<cmd>lua require("various-textobjs").shellPipe(false)<CR>'
			)

			vim.keymap.set('n', 'gx', function()
				-- select URL
				require('various-textobjs').url()

				-- plugin only switches to visual mode when textobj found
				local foundURL = vim.fn.mode():find('v')

				-- if not found, search whole buffer via urlview.nvim instead
				if not foundURL then
					vim.cmd.UrlView('buffer')
					return
				end

				-- retrieve URL with the z-register as intermediary
				vim.cmd.normal({ '"zy', bang = true })
				local url = vim.fn.getreg('z')

				-- open with the OS-specific shell command
				local opener
				if vim.fn.has('macunix') == 1 then
					opener = 'open'
				elseif vim.fn.has('linux') == 1 then
					opener = 'xdg-open'
				elseif vim.fn.has('win64') == 1 or vim.fn.has('win32') == 1 then
					opener = 'start'
				end
				local openCommand = string.format("%s '%s' >/dev/null 2>&1", opener, url)
				os.execute(openCommand)
			end, { desc = 'Smart URL Opener' })

			vim.keymap.set('n', 'dsi', function()
				-- select inner indentation
				require('various-textobjs').indentation(true, true)

				-- plugin only switches to visual mode when a textobj has been found
				local notOnIndentedLine = vim.fn.mode():find('V') == nil
				if notOnIndentedLine then return end

				-- dedent indentation
				vim.cmd.normal({ '<', bang = true })

				-- delete surrounding lines
				local endBorderLn = vim.api.nvim_buf_get_mark(0, '>')[1] + 1
				local startBorderLn = vim.api.nvim_buf_get_mark(0, '<')[1] - 1
				vim.cmd(tostring(endBorderLn) .. ' delete') -- delete end first so line index is not shifted
				vim.cmd(tostring(startBorderLn) .. ' delete')
			end, { desc = 'Delete surrounding indentation' })
		end,
	},
	{
		'windwp/nvim-autopairs',
		event = 'InsertEnter',
		opts = {
			disable_in_visualblock = false,
			disable_in_replace_mode = true,
			ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
			check_ts = true,
			map_c_w = true,
			enable_check_bracket_line = true,
		},
	},
	{
		'neovim/nvim-lspconfig',
		config = function()
			require('lspconfig').rust_analyzer.setup({})
			require('lspconfig').lua_ls.setup({})
			require('lspconfig').omnisharp.setup({})
			require('lspconfig').cssls.setup({})
			require('lspconfig').html.setup({})
			require('lspconfig').jsonls.setup({})
			require('lspconfig').marksman.setup({})
			require('lspconfig').hydra_lsp.setup({})
			vim.api.nvim_create_autocmd('LspAttach', {
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

					vim.keymap.set('i', '<a-;>', '<c-x><c-o>')
					vim.keymap.set('n', ',lg', vim.diagnostic.open_float)
					vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
					vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					vim.keymap.set('n', ',la', vim.lsp.buf.declaration, opts)
					vim.keymap.set('n', ',le', vim.lsp.buf.hover, opts)
					vim.keymap.set('n', ',ls', vim.lsp.buf.signature_help, opts)
					vim.keymap.set('n', ',lw', vim.lsp.buf.rename, opts)
					vim.keymap.set({ 'n', 'v' }, ',lc', vim.lsp.buf.code_action, opts)
					vim.keymap.set(
						'n',
						',lf',
						function() vim.lsp.buf.format({ async = true }) end,
						opts
					)
				end,
			})
		end,
	},
	{
		'williamboman/mason.nvim',
		dependencies = 'neovim/nvim-lspconfig',
		config = true,
	},
	{
		'williamboman/mason-lspconfig.nvim',
		dependencies = { 'neovim/nvim-lspconfig', 'williamboman/mason.nvim' },
		opts = {
			ensure_installed = {},
			automatic_installation = true
		},
	},
	{
		'nvimtools/none-ls.nvim',
		-- main = 'null-ls',
		dependencies = 'plenary.nvim',
		config = function()
			require('null-ls').setup({
				sources = {
					require('null-ls').builtins.formatting.stylua.with({
						extra_args = {
							'--call-parentheses',
							'Always',
							'--collapse-simple-statement',
							'Always',
							'--column-width',
							'100',
							'--indent-type',
							'Tabs',
							'--line-endings',
							'Unix',
							'--quote-style',
							'AutoPreferSingle',
						},
					}),
					require('null-ls').builtins.formatting.prettier.with({
						extra_args = {
							-- '--no-bracket-spacing',
							'--print-width',
							'100',
							'--single-quote',
							'--use-tabs',
						},
						filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'css', 'scss', 'less', 'html', 'json', 'jsonc', 'yaml', 'graphql', 'handlebars' }
					}),
					require('null-ls').builtins.diagnostics.fish,
					-- require('null-ls').builtins.diagnostics.commitlint,
					-- require('null-ls').builtins.diagnostics.gitlint,
					require('null-ls').builtins.formatting.fish_indent,
					require('null-ls').builtins.hover.dictionary,
				},
			})
		end,
	},
	{
		'jay-babu/mason-null-ls.nvim',
		event = { 'BufReadPre', 'BufNewFile' },
		dependencies = { 'mason.nvim', 'none-ls.nvim' },
		opts = {
			automatic_installation = true,
			handlers = {},
			methods = {
				diagnostics = true,
				formatting = true,
				code_actions = true,
				completion = true,
				hover = true,
			},
		},
	},
})
vim.api.nvim_set_hl(0, 'LeapLabelPrimary', { fg = '#0f0f0f', bg = '#ffafd7' })
vim.api.nvim_set_hl(0, 'LeapLabelSecondary', { fg = '#0f0f0f', bg = '#ffd75f' })
