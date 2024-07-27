---@type LazySpec
return {
	'tpope/vim-repeat',
	'zhimsel/vim-stay',
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
		cmd = 'EasyAlign',
		keys = {
			{ mode = { 'n', 'x' }, 'gx', '<Plug>(EasyAlign)' },
		},
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
		opts = function(_, opts)
			local prev_func = opts.on_open
			opts.on_open = function(win)
				prev_func(win)
				vim.api.nvim_win_set_config(win, {
					border = env.borders,
				})
			end
			return require('astrocore').extend_tbl(opts, {
				background_colour = '#292828',
				render = 'wrapped-compact',
				stages = 'static',
			})
		end,
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
	{
		'jinh0/eyeliner.nvim',
		opts = {
			highlight_on_key = true,
			dim = false,
		},
	},
	{
		'kylechui/nvim-surround',
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
		event = 'User AstroGitFile',
	},
	{
		'nvim-tree/nvim-web-devicons',
		opts = function(_, opts)
			opts.override.mp4 = nil
		end
	}
}
