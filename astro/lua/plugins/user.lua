---@type LazySpec
return {
	{
		'sainnhe/gruvbox-material',
		lazy = false,
		priority = 1000,
	},
	{
		'rcarriga/nvim-notify',
		lazy = true,
		config = function (plugin, opts)
			opts.background_colour = '#292828'
			require('astronvim.plugins.configs.notify')(plugin, opts)
		end
	},
	{
		'L3MON4D3/LuaSnip',
		config = function(plugin, opts)
			require('astronvim.plugins.configs.luasnip')(plugin, opts) -- include the default astronvim config that calls the setup call
			-- add more custom luasnip configuration such as filetype extend or custom snippets
			local luasnip = require('luasnip')
		end,
	},

	{
		'windwp/nvim-autopairs',
		config = function(plugin, opts)
			require('astronvim.plugins.configs.nvim-autopairs')(plugin, opts) -- include the default astronvim config that calls the setup call
			-- add more custom autopairs configuration such as custom rules
			local npairs = require('nvim-autopairs')
			local rule = require('nvim-autopairs.rule')
			local cond = require('nvim-autopairs.conds')
			npairs.add_rules(
				{
					rule('$', '$', { 'tex', 'latex' })
						-- don't add a pair if the next character is %
						:with_pair(
							cond.not_after_regex('%%')
						)
						-- don't add a pair if  the previous character is xxx
						:with_pair(
							cond.not_before_regex('xxx', 3)
						)
						-- don't move right when repeat character
						:with_move(cond.none())
						-- don't delete if the next character is xx
						:with_del(cond.not_after_regex('xx'))
						-- disable adding a newline when you press <cr>
						:with_cr(cond.none()),
				},
				-- disable for .vim files, but it work for another filetypes
				rule('a', 'a', '-vim')
			)
		end,
	},
}
