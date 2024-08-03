---@type LazyPluginSpec[]
return {
	-- { 'Bilal2453/luvit-meta', lazy = true },
	{
		'folke/lazydev.nvim',
		cmd = 'LazyDev',
		dependencies = {
			'neovim/nvim-lspconfig'
		},
		opts = {
			library = {
				{ path = 'luvit-meta/library', words = { 'vim%.uv' } },
				{ path = 'astrolsp', words = { 'AstroLSP' } },
				{ path = 'lazy.nvim', words = { 'Lazy' } },
			},
		},
	},
	{
		'williamboman/mason.nvim',
		build = ':MasonUpdate',
		cmd = {
			'Mason',
			'MasonInstall',
			'MasonUninstall',
			'MasonUninstallAll',
			'MasonLog',
		},
		opts = {
			ui = {
				icons = {
					package_installed = '✓',
					package_uninstalled = '✗',
					package_pending = '⟳',
				},
			},
		},
	},
	{
		'williamboman/mason-lspconfig.nvim',
		cmd = { 'LspInstall', 'LspUninstall' },
		opts_extend = { 'ensure_installed' },
		opts = {
			ensure_installed = env.lsps,
		},
		dependencies = { 'williamboman/mason.nvim' },
	},
	{
		'neovim/nvim-lspconfig',
		cmd = { 'LspInfo', 'LspLog', 'LspStart', 'Neoconf' },
		dependencies = {
			{ 'folke/neoconf.nvim', opts = {} },
			{ 'williamboman/mason-lspconfig.nvim' },
			{ 'AstroNvim/astrolsp' },
		},
		config = function(_, opts)
			vim.tbl_map(require('astrolsp').lsp_setup, require('astrolsp').config.servers)
			env.emit_bufs('FileType', { group = 'lspconfig' })
			vim.cmd('silent! LspStart')
		end,
	},
}
