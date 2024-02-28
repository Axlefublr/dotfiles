return {
	'kana/vim-textobj-user',
	'tpope/vim-repeat',
	'adelarsq/vim-matchit',
	'farmergreg/vim-lastplace',
	'xiyaowong/transparent.nvim',
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
}
