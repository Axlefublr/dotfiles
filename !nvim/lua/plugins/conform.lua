---@type LazyPluginSpec
return {
	'stevearc/conform.nvim',
	lazy = true,
	cmd = 'ConformInfo',
	opts = {
		format_on_save = false,
		notify_on_error = true,
		formatters_by_ft = env.formatters_by_ft,
		formatters = {
			black = {
				prepend_args = { '--skip-string-normalization' },
			},
		},
	},
	config = function(_, opts)
		require('conform').setup(opts)
		vim.opt.formatexpr = 'v:lua.require("conform").formatexpr()'
	end,
}
