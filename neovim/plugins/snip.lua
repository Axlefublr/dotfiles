return {
	{
		'L3MON4D3/LuaSnip',
		version = 'v2.*',
		build = 'make install_jsregexp',
		config = function()
			vim.keymap.set(
				{ 'i', 's' },
				'<a-l>',
				function() require('luasnip').jump(1) end,
				{ silent = true }
			)
			vim.keymap.set(
				{ 'i', 's' },
				'<a-h>',
				function() require('luasnip').jump(-1) end,
				{ silent = true }
			)
		end,
	},
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'neovim/nvim-lspconfig',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
		},
		config = function()
			local cmp = require('cmp')
			cmp.setup({
				performance = {
					throttle = 0,
				},
				snippet = {
					expand = function(args) require('luasnip').lsp_expand(args.body) end,
				},
				window = {
					completion = {
						scrolloff = 99,
						scrollbar = false,
					},
				},
				view = {
					docs = {
						auto_open = false,
					},
				},
				mapping = cmp.mapping.preset.insert({
					['<a-o>'] = function(_)
						if cmp.visible() then
							cmp.abort()
						else
							cmp.complete()
						end
					end,
					['<f5>'] = cmp.mapping.confirm({
						select = true,
						behavior = cmp.ConfirmBehavior.Replace,
					}),
					['<a-;>'] = cmp.mapping.confirm({
						select = true,
						behavior = cmp.ConfirmBehavior.Insert,
					}),
					['<a-i>'] = function()
						if cmp.visible_docs() then
							cmp.close_docs()
						else
							cmp.open_docs()
						end
					end,
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
				}, { { name = 'buffer' } }),
			})

			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			local servers = {
				'lua_ls',
				'rust_analyzer',
				'omnisharp',
				'cssls',
				'html',
				'jsonls',
				'marksman',
				'hydra_lsp',
			}
			for _, server in ipairs(servers) do
				require('lspconfig')[server].setup({
					capabilities = capabilities,
				})
			end
		end,
	},
}
