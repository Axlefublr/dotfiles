return {
	-- 'kana/vim-textobj-user',
	'tpope/vim-repeat',
	'adelarsq/vim-matchit',
	'farmergreg/vim-lastplace',
	{
		'wellle/targets.vim',
		init = function() vim.g.targets_nl = 'nh' end, -- for some reason, `config` doesn't work but `init` does
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
		'kylechui/nvim-surround',
		version = '*',
		event = 'VeryLazy',
		config = true,
	},
	{
		'windwp/nvim-autopairs',
		event = 'InsertEnter',
		dependencies = 'hrsh7th/nvim-cmp',
		config = function()
			local plugin = require('nvim-autopairs')
			plugin.setup({
				disable_in_visualblock = false,
				disable_in_replace_mode = true,
				ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
				check_ts = true,
				map_c_w = true,
				enable_check_bracket_line = true,
			})
			local rule = require('nvim-autopairs.rule')
			plugin.add_rule(rule('<', '>'))

			local cmp_autopairs = require('nvim-autopairs.completion.cmp')
			local cmp = require('cmp')
			cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
		end,
	},
	{
		'numToStr/Comment.nvim',
		keys = {
			{ mode = { 'n', 'x' }, 'gd' },
			{ mode = { 'n', 'x' }, 'gh' },
			{ 'gdd' },
			{ 'ghh' },
			{ 'gdo' },
			{ 'gdO' },
			{ 'gdl' },
		},
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
		cmd = 'GuessIndent',
		opts = {
			auto_cmd = true,
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
		config = true,
		keys = {
			{ ',aM', function() require('harpoon'):list():prepend() end },
			{ ',am', function() require('harpoon'):list():append() end },
			{ '""',  function() require('harpoon').ui:toggle_quick_menu(harpoon:list()) end },

			{ '"a',  function() require('harpoon'):list():select(1) end },
			{ '"s',  function() require('harpoon'):list():select(2) end },
			{ '"d',  function() require('harpoon'):list():select(3) end },
			{ '"f',  function() require('harpoon'):list():select(4) end },
			{ '"g',  function() require('harpoon'):list():select(5) end },
			{ '"z',  function() require('harpoon'):list():select(6) end },
			{ '"x',  function() require('harpoon'):list():select(7) end },
			{ '"c',  function() require('harpoon'):list():select(8) end },
			{ '"v',  function() require('harpoon'):list():select(9) end },
			{ '"b',  function() require('harpoon'):list():select(10) end },
			{ '"A',  function() require('harpoon'):list():select(11) end },
			{ '"S',  function() require('harpoon'):list():select(12) end },
			{ '"D',  function() require('harpoon'):list():select(13) end },
			{ '"F',  function() require('harpoon'):list():select(14) end },
			{ '"G',  function() require('harpoon'):list():select(15) end },
			{ '"Z',  function() require('harpoon'):list():select(16) end },
			{ '"X',  function() require('harpoon'):list():select(17) end },
			{ '"C',  function() require('harpoon'):list():select(18) end },
			{ '"V',  function() require('harpoon'):list():select(19) end },
			{ '"B',  function() require('harpoon'):list():select(20) end },
		},
	},
	{
		'Wansmer/treesj',
		keys = {
			{ ',dj', function() require('treesj').join() end },
			{ ',dk', function() require('treesj').split() end },
			{ ',dJ', function() require('treesj').join({ split = { recursive = true } }) end },
			{ ',dK', function() require('treesj').split({ split = { recursive = true } }) end },
		},
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		opts = {
			use_default_keymaps = false,
		},
	},
}
