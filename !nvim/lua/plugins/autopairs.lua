return {
	'windwp/nvim-autopairs',
	event = 'InsertEnter',
	opts = {
		check_ts = true,
		ts_config = { java = false },
		disable_in_visualblock = false,
		disable_in_replace_mode = true,
		ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
		map_c_w = true,
		enable_check_bracket_line = true,
		fast_wrap = false,
	},
	config = function(_, opts)
		local autopairs = require('nvim-autopairs')
		autopairs.setup(opts)
		local rule = require('nvim-autopairs.rule')
		-- local cond = require('nvim-autopairs.conds')

		env.on_load(
			'nvim-cmp',
			function()
				require('cmp').event:on(
					'confirm_done',
					require('nvim-autopairs.completion.cmp').on_confirm_done({ tex = false })
				)
			end
		)

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
	end,
}
