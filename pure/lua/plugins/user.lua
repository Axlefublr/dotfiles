return {
	'tpope/vim-repeat',
	'zhimsel/vim-stay',
	{
		'echasnovski/mini.bufremove',
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
		'NMAC427/guess-indent.nvim', -- FIXME: lazy load this
		cmd = 'GuessIndent',
		opts = {
			auto_cmd = true,
			buftype_exclude = {
				'help',
				'nofile',
				'terminal',
				'prompt',
			},
		},
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
		'jinh0/eyeliner.nvim', -- FIXME: lazy load on_keys fFtT
		opts = {
			highlight_on_key = true,
			dim = false,
		},
	},
	{
		'kylechui/nvim-surround', -- FIXME: lazyload on keys
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
		'tpope/vim-fugitive', -- FIXME: lazy load on first gittable file, create RealFile and GitFile events
		-- event = 'User AstroGitFile',
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
				vim.wo[win].conceallevel = 3
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
}
