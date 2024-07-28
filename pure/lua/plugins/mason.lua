return {
	{
		'williamboman/mason-lspconfig.nvim',
		opts_extend = 'ensure_installed',
		opts = {
			ensure_installed = env.lsps
		}
	},
}
