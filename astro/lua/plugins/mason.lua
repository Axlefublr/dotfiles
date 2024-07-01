---@type LazySpec
return {
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
		end
	},
	{
		'jay-babu/mason-null-ls.nvim',
		opts = function(_, opts)
			opts.ensure_installed = require('astrocore').list_insert_unique(opts.ensure_installed, { 'stylua' })
		end
	},
}
