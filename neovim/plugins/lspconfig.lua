return {
	{
		'williamboman/mason.nvim',
		dependencies = 'neovim/nvim-lspconfig',
		config = true,
	},
	{
		'williamboman/mason-lspconfig.nvim',
		dependencies = { 'neovim/nvim-lspconfig', 'williamboman/mason.nvim' },
		opts = {
			ensure_installed = {},
			automatic_installation = true,
		},
	},
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			{ 'folke/neoconf.nvim', config = true }, --[[ 'lvimuser/lsp-inlayhints.nvim' ]]
		},
		config = function()
			local servers = {
				'rust_analyzer',
				'lua_ls',
				'csharp_ls',
				'cssls',
				'html',
				'jsonls',
				'marksman',
				'yamlls',
				'taplo',
			}
			for _, server in ipairs(servers) do
				require('lspconfig')[server].setup({})
			end

			vim.api.nvim_create_autocmd('LspAttach', {
				callback = function(args)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[args.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
					-- require('lsp-inlayhints').on_attach(
					-- 	vim.lsp.get_client_by_id(args.data.client_id),
					-- 	args.buf
					-- )

					vim.keymap.set('n', ',la', function()
						vim.diagnostic.open_float()
						vim.diagnostic.open_float()
					end)
					vim.keymap.set('n', '[d', function()
						for _ = 1, vim.v.count1 do
							vim.diagnostic.goto_prev()
						end
					end)
					vim.keymap.set('n', ']d', function()
						for _ = 1, vim.v.count1 do
							vim.diagnostic.goto_next()
						end
					end)
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = args.buf }
					vim.keymap.set('n', ',lg', vim.lsp.buf.declaration, opts)
					vim.keymap.set('n', ',le', function()
						vim.lsp.buf.hover()
						vim.lsp.buf.hover()
					end, opts)
					vim.keymap.set({ 'n', 'i' }, '<a-u>', vim.lsp.buf.signature_help, opts)
					vim.keymap.set('n', ',lw', vim.lsp.buf.rename, opts)
					vim.keymap.set({ 'n', 'x' }, ',lc', vim.lsp.buf.code_action, opts)
					vim.keymap.set(
						'n',
						',lf',
						function() vim.lsp.buf.format({ async = true }) end,
						opts
					)
				end,
			})
		end,
	},
}
