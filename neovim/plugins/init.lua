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
	{
		'nmac427/guess-indent.nvim',
		opts = {
			buftype_exclude = { -- A list of buffer types for which the auto command gets disabled
				'help',
				'nofile',
				'terminal',
				'prompt',
			},
		},
	},
	{
		'ThePrimeagen/harpoon',
		branch = 'harpoon2',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			local harpoon = require('harpoon')
			harpoon:setup()

			vim.keymap.set('n', ',aM', function() harpoon:list():prepend() end)
			vim.keymap.set('n', ',am', function() harpoon:list():append() end)
			vim.keymap.set('n', '""', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

			vim.keymap.set('n', '"a', function() harpoon:list():select(1) end)
			vim.keymap.set('n', '"s', function() harpoon:list():select(2) end)
			vim.keymap.set('n', '"d', function() harpoon:list():select(3) end)
			vim.keymap.set('n', '"f', function() harpoon:list():select(4) end)
			vim.keymap.set('n', '"g', function() harpoon:list():select(5) end)
			vim.keymap.set('n', '"z', function() harpoon:list():select(6) end)
			vim.keymap.set('n', '"x', function() harpoon:list():select(7) end)
			vim.keymap.set('n', '"c', function() harpoon:list():select(8) end)
			vim.keymap.set('n', '"v', function() harpoon:list():select(9) end)
		end,
	},
}
