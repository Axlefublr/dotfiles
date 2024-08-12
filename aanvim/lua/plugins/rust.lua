---@type LazyPluginSpec[]
return {
	{
		'mrcjkb/rustaceanvim',
		ft = 'rust',
		lazy = true,
		version = '^4',
		cmd = { 'RustLsp' },
		dependencies = {
			'neovim/nvim-lspconfig',
		},
		config = function()
			vim.g.rustaceanvim = {
				server = require('astrolsp').lsp_opts('rust_analyzer'),
			}
		end,
	},
	{
		'Saecki/crates.nvim',
		lazy = true,
		opts = {
			completion = {
				cmp = { enabled = true },
			},
		},
	},
}
