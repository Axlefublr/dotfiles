---@type LazyPluginSpec[]
return {
	{
		'tpope/vim-repeat',
		event = 'User WayAfter',
	},
	{
		'zhimsel/vim-stay',
		event = 'BufEnter',
	},
	{
		'echasnovski/mini.bufremove',
		opts = {},
		lazy = true,
	},
	{
		'sainnhe/gruvbox-material',
		priority = 1000,
		config = function()
			vim.cmd.colorscheme('gruvbox-material')
			env.saquire('highlights')
		end,
	},
	{
		'wellle/targets.vim',
		keys = {
			{ mode = { 'x', 'o' }, 'i' },
			{ mode = { 'x', 'o' }, 'a' },
		},
		init = function() vim.g.targets_nl = 'nh' end,
	},
	{
		'vim-scripts/ReplaceWithRegister',
		keys = {
			{ 'grr', '<Plug>ReplaceWithRegisterLine' },
			{ 'gr' },
		},
	},
	{
		'junegunn/vim-easy-align',
		cmd = 'EasyAlign',
		keys = {
			{ mode = { 'n', 'x' }, 'gx', '<Plug>(EasyAlign)' },
		},
	},
	{
		'NMAC427/guess-indent.nvim',
		cmd = 'GuessIndent',
		opts = {
			auto_cmd = false,
			buftype_exclude = {
				'help',
				'nofile',
				'terminal',
				'prompt',
			},
		},
		init = function()
			env.acmd('BufReadPost', nil, function(args) require('guess-indent').set_from_buffer(args.buf, true, true) end)
			env.acmd('BufNewFile', nil, function(args)
				env.acmd(
					'BufWritePost',
					nil,
					function(write_args) require('guess-indent').set_from_buffer(write_args.buf, true, true) end,
					{ buffer = args.buf, once = true }
				)
			end)
		end,
	},
	{
		'Wansmer/treesj',
		lazy = true,
		keys = {
			{ '<Leader>dj', function() require('treesj').join() end }, -- MOVE
			{ '<Leader>dk', function() require('treesj').split() end },
			{ '<Leader>dJ', function() require('treesj').join({ split = { recursive = true } }) end },
			{ '<Leader>dK', function() require('treesj').split({ split = { recursive = true } }) end },
		},
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
	},
	{
		'chrisgrieser/nvim-spider',
		lazy = true,
		keys = {
			{ mode = { 'n', 'o', 'x' }, 'w', "<Cmd>lua require('spider').motion('w')<CR>" },
			{ mode = { 'n', 'o', 'x' }, 'e', "<Cmd>lua require('spider').motion('e')<CR>" },
			{ mode = { 'n', 'o', 'x' }, 'b', "<Cmd>lua require('spider').motion('b')<CR>" },
			{ mode = { 'n', 'o', 'x' }, 'ge', "<Cmd>lua require('spider').motion('ge')<CR>" },
		},
		opts = {
			subwordMovement = false,
		},
	},
	{
		'windwp/nvim-ts-autotag',
		ft = 'html',
		opts = {},
	},
	{
		'jinh0/eyeliner.nvim',
		pin = true,
		keys = {
			{ mode = { 'n', 'x', 'o' }, 'f' },
			{ mode = { 'n', 'x', 'o' }, 'F' },
			{ mode = { 'n', 'x', 'o' }, 't' },
			{ mode = { 'n', 'x', 'o' }, 'T' },
		},
		opts = {
			highlight_on_key = true,
			dim = false,
		},
		config = function(_, opts)
			env.set_high('EyelinerPrimary', { fg = env.color.level, bg = env.color.shell_pink, bold = true })
			env.set_high('EyelinerSecondary', { fg = env.color.level, bg = env.color.shell_yellow, bold = true })
			require('eyeliner').setup(opts)
		end,
	},
	{
		'kylechui/nvim-surround',
		keys = {
			'ys',
			'cs',
			'ds',
			{ mode = 'x', 'c' },
		},
		version = '*',
		opts = {
			keymaps = {
				visual = 'c',
			},
		},
	},
	{
		'johmsalas/text-case.nvim',
		event = 'CmdlineEnter',
		opts = {
			default_keymappings_enabled = false,
			substitude_command_name = 'S',
		},
		cmd = {
			'Subs',
		},
	},
	{
		'tpope/vim-fugitive',
		cmd = { 'Git', 'G' },
	},
	{
		'rcarriga/nvim-notify',
		lazy = true,
		init = function() env.func_loads_plugin('nvim-notify', vim, 'notify') end,
		opts = {
			background_colour = '#292828',
			render = 'wrapped-compact',
			stages = 'static',
			on_open = function(window)
				vim.api.nvim_win_set_config(window, {
					border = env.borders,
					zindex = 175,
				})
				if env.plugalid('nvim-treesitter') then require('lazy').load({ plugins = { 'nvim-treesitter' } }) end
				vim.wo[window].conceallevel = 3
				local buffer = vim.api.nvim_win_get_buf(window)
				if not pcall(vim.treesitter.start, buffer, 'markdown') then vim.bo[buffer].syntax = 'markdown' end
			end,
			icons = {
				DEBUG = env.icons.debug,
				ERROR = env.icons.diag_error,
				INFO = env.icons.diag_info,
				TRACE = env.icons.diag_hint,
				WARN = env.icons.diag_warn,
			},
		},
		config = function(_, opts)
			require('notify').setup(opts)
			vim.notify = require('notify').notify
		end,
	},
	{
		'stevearc/quicker.nvim',
		lazy = true,
		---@module "quicker"
		---@type quicker.SetupOptions
		opts = {
			keys = {
				{
					'>',
					function() require('quicker').expand({ add_to_existing = true }) end,
					desc = 'Expand quickfix context',
				},
				{
					'<',
					function() require('quicker').collapse() end,
					desc = 'Collapse quickfix context',
				},
			},
		},
	},
}
