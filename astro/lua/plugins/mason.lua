---@type LazySpec
return {
	{
		'nvimtools/none-ls.nvim',
		opts = function(_, opts)
			local null_ls = require('null-ls')
			if not opts.builtins then opts.builtins = {} end
			null_ls.register(null_ls.builtins.diagnostics.sqlfluff.with({
				extra_args = { '--dialect', 'postgres' },
			}))
		end,
	},
}
