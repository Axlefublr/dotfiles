---@type LazySpec
return {
	'tpope/vim-repeat',
	'farmergreg/vim-lastplace',
	{
		'sainnhe/gruvbox-material',
		priority = 1000,
	},
	{
		'wellle/targets.vim',
		event = 'VeryLazy',
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
		keys = {
			{ mode = { 'n', 'x' }, 'ga', '<Plug>(EasyAlign)' },
		},
	},
	{
		'bkad/CamelCaseMotion',
		event = 'VeryLazy',
		init = function() vim.g.camelcasemotion_key = '<Leader>' end, -- only `init` works
	},
	{
		'NMAC427/guess-indent.nvim',
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
		keys = {
			{ '<Leader>dj', function() require('treesj').join() end },
			{ '<Leader>dk', function() require('treesj').split() end },
			{ '<Leader>dJ', function() require('treesj').join({ split = { recursive = true } }) end },
			{ '<Leader>dK', function() require('treesj').split({ split = { recursive = true } }) end },
		},
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
	},
	{
		'rcarriga/nvim-notify',
		event = 'VeryLazy',
		opts = {
			background_colour = '#292828',
		},
	},
	{
		'Axlefublr/harp-nvim',
		lazy = true,
		dev = true,
		opts = {},
	},
	{
		'onsails/lspkind.nvim',
		opts = {
			symbol_map = {
				Text = '󰉿',
				String = '󰉿',
				Function = '󰹧',
				Method = '󰹧',
				Variable = '󰸌',
				Class = '󰠱',
			},
		},
	},
	{
		'kevinhwang91/nvim-ufo',
		opts = {
			open_fold_hl_timeout = 100,
			provider_selector = function() return { 'treesitter', 'indent' } end,
		},
	},
}
