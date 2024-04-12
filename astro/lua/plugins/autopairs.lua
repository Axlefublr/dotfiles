return {
	'windwp/nvim-autopairs',
	opts = function(_, opts)
		local core = require('astrocore')
		if not opts.fast_wrap then
			opts.fast_wrap = {}
		end
		core.list_insert_unique(opts.fast_wrap.chars, { '<' })
		return core.extend_tbl(opts, {
			disable_in_visualblock = false,
			disable_in_replace_mode = true,
			ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
			map_c_w = true,
			enable_check_bracket_line = true,
		})
	end,
	config = function(_, opts)
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
	end,
}
