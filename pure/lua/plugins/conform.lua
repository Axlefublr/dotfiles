return {
	'stevearc/conform.nvim',
	lazy = true,
	cmd = 'ConformInfo',
	opts = {
		format_on_save = false,
		notify_on_error = true,
		formatters_by_ft = {
			lua = { 'stylua' },
		},
		formatters = {
			black = {
				prepend_args = { '--skip-string-normalization' },
			},
		},
	},
	dependencies = {
		{ 'williamboman/mason.nvim', optional = true },
		{
			'AstroNvim/astrocore',
			opts = {
				options = { opt = { formatexpr = "v:lua.require'conform'.formatexpr()" } },
			},
		},
	},
	config = function(_, opts)
		require('conform').setup(opts)
		vim.opt.formatexpr = 'v:lua.require("conform").formatexpr()'
	end,
}
