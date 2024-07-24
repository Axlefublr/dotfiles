---@type LazySpec
return {
	{ 'Axlefublr/edister.nvim', lazy = true, dev = true },
	{
		'Axlefublr/harp-nvim',
		lazy = true,
		dev = true,
		opts = {},
	},
	{
		'Axlefublr/qfetter.nvim',
		lazy = true,
		dev = true
	},
	{
		'Axlefublr/lupa.nvim',
		lazy = true,
		dev = true
	},
	{
		'Axlefublr/selabel.nvim',
		dev = true,
		opts = {
			win_opts = {
				border = env.border,
			}
		},
		config = function(_, opts)
			require('selabel').setup(opts)
			env.select = require('selabel').select_nice
		end
	},
}
