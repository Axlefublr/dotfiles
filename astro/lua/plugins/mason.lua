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
	{
		'nvim-treesitter/nvim-treesitter',
		opts = function(_, opts)
			opts.ensure_installed = require('astrocore').list_insert_unique(opts.ensure_installed, {
				'diff',
			})
		end,
	},
}
