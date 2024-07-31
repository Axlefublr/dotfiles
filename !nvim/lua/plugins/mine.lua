---@type LazyPluginSpec[]
return {
	{ 'Axlefublr/edister.nvim', lazy = true, dev = true, opts = { border = env.borders } },
	{
		'Axlefublr/harp-nvim',
		lazy = true,
		dev = true,
		opts = {},
	},
	{
		'Axlefublr/qfetter.nvim',
		lazy = true,
		dev = true,
	},
	{
		'Axlefublr/lupa.nvim',
		lazy = true,
		dev = true,
	},
	{
		'Axlefublr/selabel.nvim',
		dev = true,
		lazy = true,
		init = function()
			env.func_loads_plugin('selabel.nvim', env, 'select')
			env.func_loads_plugin('selabel.nvim', vim.ui, 'select')
		end,
		opts = {
			separator = ' ',
			-- separator_highlight = 'Orange',
			win_opts = {
				border = env.borders,
			},
		},
		config = function(_, opts)
			require('selabel').setup(opts)
			env.select = require('selabel').select_nice
		end,
	},
}
