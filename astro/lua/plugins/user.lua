---@type LazySpec
return {
	'tpope/vim-repeat',
	'farmergreg/vim-lastplace',
	{
		'sainnhe/gruvbox-material',
		lazy = false,
		priority = 1000,
	},
	{
		'wellle/targets.vim',
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
			{ mode = '', 'ga', '<Plug>(EasyAlign)' },
		},
	},
	{
		'bkad/CamelCaseMotion',
		init = function() vim.g.camelcasemotion_key = '<leader>' end, -- only `init` works
	},
	{
		'nmac427/guess-indent.nvim',
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
		config = function(plugin, opts)
			opts.background_colour = '#292828'
			require('astronvim.plugins.configs.notify')(plugin, opts)
		end,
	},
}
