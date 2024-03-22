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
		keys = {
			{ ',aM' },
			{ ',am' },
			{ '""' },
			{ '"a' },
			{ '"s' },
			{ '"d' },
			{ '"f' },
			{ '"g' },
			{ '"z' },
			{ '"x' },
			{ '"c' },
			{ '"v' },
			{ '"b' },
			{ '"A' },
			{ '"S' },
			{ '"D' },
			{ '"F' },
			{ '"G' },
			{ '"Z' },
			{ '"X' },
			{ '"C' },
			{ '"V' },
			{ '"B' },
		},
		config = function()
			local harpoon = require('harpoon')
			harpoon.setup()

			vim.keymap.set('n', ',aM', function() harpoon:list():prepend() end)
			vim.keymap.set('n', ',am', function() harpoon:list():append() end)
			vim.keymap.set(
				'n',
				'""',
				function() harpoon.ui:toggle_quick_menu(harpoon:list()) end
			)

			vim.keymap.set('n', '"a', function() harpoon:list():select(1) end)
			vim.keymap.set('n', '"s', function() harpoon:list():select(2) end)
			vim.keymap.set('n', '"d', function() harpoon:list():select(3) end)
			vim.keymap.set('n', '"f', function() harpoon:list():select(4) end)
			vim.keymap.set('n', '"g', function() harpoon:list():select(5) end)
			vim.keymap.set('n', '"z', function() harpoon:list():select(6) end)
			vim.keymap.set('n', '"x', function() harpoon:list():select(7) end)
			vim.keymap.set('n', '"c', function() harpoon:list():select(8) end)
			vim.keymap.set('n', '"v', function() harpoon:list():select(9) end)
			vim.keymap.set('n', '"b', function() harpoon:list():select(10) end)
			vim.keymap.set('n', '"A', function() harpoon:list():select(11) end)
			vim.keymap.set('n', '"S', function() harpoon:list():select(12) end)
			vim.keymap.set('n', '"D', function() harpoon:list():select(13) end)
			vim.keymap.set('n', '"F', function() harpoon:list():select(14) end)
			vim.keymap.set('n', '"G', function() harpoon:list():select(15) end)
			vim.keymap.set('n', '"Z', function() harpoon:list():select(16) end)
			vim.keymap.set('n', '"X', function() harpoon:list():select(17) end)
			vim.keymap.set('n', '"C', function() harpoon:list():select(18) end)
			vim.keymap.set('n', '"V', function() harpoon:list():select(19) end)
			vim.keymap.set('n', '"B', function() harpoon:list():select(20) end)
		end,
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
