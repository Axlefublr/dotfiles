---@type LazySpec
return {
	{
		'Saecki/crates.nvim',
		opts = {
			null_ls = {
				enabled = false,
			},
		},
	},
	{
		'nvim-treesitter/nvim-treesitter',
		opts = function(_, opts)
			opts.ensure_installed = require('astrocore').list_insert_unique(opts.ensure_installed, {
				'diff',
				'lua',
			})
		end,
	},
	{
		'williamboman/mason-lspconfig.nvim',
		opts = function(_, opts)
			opts.ensure_installed = require('astrocore').list_insert_unique(opts.ensure_installed, { 'lua_ls' })
		end,
	},
	{ 'jay-babu/mason-null-ls.nvim', optional = true, opts = { methods = { formatting = false } } },
	{
		'stevearc/conform.nvim',
		lazy = true,
		event = 'User AstroFile',
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
	},
}
