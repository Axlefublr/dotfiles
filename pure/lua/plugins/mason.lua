return {
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
			handlers = { function(server) require('astrolsp').lsp_setup(server) end },
		},
		dependencies = { 'williamboman/mason.nvim' },
	},
	{ 'folke/neodev.nvim', lazy = true, opts = {} },
	{
		'neovim/nvim-lspconfig',
		cmd = { 'LspInfo', 'LspLog', 'LspStart', 'Neoconf' },
		dependencies = {
			{ 'folke/neoconf.nvim', lazy = true, opts = {} },
			{ 'williamboman/mason-lspconfig.nvim' },
		},
		config = function(_, opts)
			local setup_servers = function()
				vim.tbl_map(require('astrolsp').lsp_setup, require('astrolsp').config.servers)
				env.emit_bufs('FileType', { group = 'lspconfig' })
			end
			if env.plugalid('mason-lspconfig.nvim') then
				env.on_load('mason-lspconfig.nvim', setup_servers)
			else
				setup_servers()
			end
		end,
	},
}
