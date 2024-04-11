return {
	'windwp/nvim-autopairs',
	config = function(_, opts)
		opts.disable_in_visualblock = false
		opts.disable_in_replace_mode = true
		opts.ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=]
		opts.check_ts = true
		opts.map_c_w = true
		opts.enable_check_bracket_line = true

		require('astronvim.plugins.configs.nvim-autopairs')(plugin, opts)
		local autopairs = require('nvim-autopairs')
		local rule = require('nvim-autopairs.rule')
		-- local cond = require('nvim-autopairs.conds')
		autopairs.add_rules({
			rule('<', '>'):with_pair(function(opts) return opts.next_char ~= '>' end),
			rule('>', '>')
				:with_pair(function(_) return false end)
				:with_move(function(opts) return opts.char == '>' end)
				:use_key('>'), -- The key that triggers the move feature
			rule(' ', ' '):with_pair(function(options)
				local pair = options.line:sub(options.col - 1, options.col)
				return vim.tbl_contains({ '()', '[]', '{}' }, pair)
			end),
		})
		local cmp_autopairs = require('nvim-autopairs.completion.cmp')
		local cmp = require('cmp')
		cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
	end,
}
