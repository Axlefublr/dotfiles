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
	-- {
	-- 	'bkad/CamelCaseMotion',
	-- 	event = 'VeryLazy',
	-- 	init = function() vim.g.camelcasemotion_key = '<Leader>' end, -- only `init` works
	-- },
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
			render = 'wrapped-compact',
			stages = 'static',
		},
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
	{
		'ErichDonGubler/lsp_lines.nvim',
		event = 'LspAttach',
		opts = {},
		enabled = false,
	},
	{
		'stevearc/dressing.nvim',
		opts = {
			input = { enabled = false },
		},
	},
	{
		'chrisgrieser/nvim-spider',
		lazy = true,
		opts = {
			subwordMovement = false,
		},
		-- dependencies = {
		-- 	'theHamsta/nvim_rocks',
		-- 	build = 'hererocks . -j2.1.0-beta3 -r3.0.0 && cp nvim_rocks.lua lua',
		-- 	config = function() require('nvim_rocks').ensure_installed('luautf8') end,
		-- },
	},
	{
		'windwp/nvim-ts-autotag',
		event = false,
		ft = 'html',
	},
}
