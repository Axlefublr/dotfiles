return {
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
			local autopairs = require('nvim-autopairs')
			autopairs.setup({
				disable_in_visualblock = false,
				disable_in_replace_mode = true,
				ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
				check_ts = true,
				map_c_w = true,
				enable_check_bracket_line = true,
			})
			local rule = require('nvim-autopairs.rule')

			autopairs.add_rules({
				rule('<', '>'):with_pair(function(opts) return opts.next_char ~= '>' end),
				rule('>', '>')
					:with_pair(function(_) return false end)
					:with_move(function(opts) return opts.char == '>' end)
					:use_key('>'), -- The key that triggers the move feature
			})

			local cmp_autopairs = require('nvim-autopairs.completion.cmp')
			local cmp = require('cmp')
			cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
		end,
	},
	{
		'numToStr/Comment.nvim',
		keys = {
			{ mode = { 'n', 'x' }, 'gd' },
			{ mode = { 'n', 'x' }, 'gD' },
			{ 'gdd' },
			{ 'gDD' },
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
				block = 'gDD',
			},
			---LHS of operator-pending mappings in NORMAL and VISUAL mode
			opleader = {
				---Line-comment keymap
				line = 'gd',
				---Block-comment keymap
				block = 'gD',
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
