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
	{
		'numToStr/Comment.nvim',
		opts = {
			---Add a space b/w comment and the line
			padding = true,
			---Whether the cursor should stay at its position
			sticky = true,
			---Lines to be ignored while (un)comment
			ignore = '^$',
			---LHS of toggle mappings in NORMAL mode
			toggler = {
				---Line-comment toggle keymap
				line = 'gdd',
				---Block-comment toggle keymap
				block = 'ghh',
			},
			---LHS of operator-pending mappings in NORMAL and VISUAL mode
			opleader = {
				---Line-comment keymap
				line = 'gd',
				---Block-comment keymap
				block = 'gh',
			},
			---LHS of extra mappings
			extra = {
				---Add comment on the line above
				above = 'gdO',
				---Add comment on the line below
				below = 'gdo',
				---Add comment at the end of line
				eol = 'gdl',
			},
			---Enable keybindings
			---NOTE: If given `false` then the plugin won't create any mappings
			mappings = {
				---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
				basic = true,
				---Extra mapping; `gco`, `gcO`, `gcA`
				extra = true,
			},
			---Function to call before (un)comment
			pre_hook = nil,
			---Function to call after (un)comment
			post_hook = nil,
		},
	},
}
