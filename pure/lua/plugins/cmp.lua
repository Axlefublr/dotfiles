return {
	{
		'hrsh7th/cmp-buffer',
		lazy = true,
	},
	{
		'amarakon/nvim-cmp-buffer-lines',
		lazy = true,
	},
	{
		'AstroNvim/astrolsp',
		opts = {
			capabilities = {
				textDocument = {
					completion = {
						completionItem = {
							documentationFormat = { 'markdown', 'plaintext' },
							snippetSupport = true,
							preselectSupport = true,
							insertReplaceSupport = true,
							labelDetailsSupport = true,
							deprecatedSupport = true,
							commitCharactersSupport = true,
							tagSupport = { valueSet = { 1 } },
							resolveSupport = { properties = { 'documentation', 'detail', 'additionalTextEdits' } },
						},
					},
				},
			},
		},
	},
	{
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		dependencies = {
			{ 'hrsh7th/cmp-path', lazy = true },
			{ 'hrsh7th/cmp-nvim-lsp', lazy = true },
		},
		opts = function(_, opts)
			local cmp = require('cmp')
			return {
				sources = {
					{ name = 'nvim_lsp', priority = 1000 },
					{ name = 'path', priority = 250 },
				},
				preselect = cmp.PreselectMode.None,
				formatting = {
					fields = { 'kind', 'abbr', 'menu' },
					format = require('lspkind').cmp_format(env.plugopts('lspkind.nvim'))
				},
				performance = {
					throttle = 0,
				},
				confirm_opts = {
					behavior = cmp.ConfirmBehavior.Insert,
					select = false,
				},
				window = {
					completion = {
						scrolloff = 99,
						scrollbar = false,
						border = false,
					},
					documentation = {
						border = env.borders,
					},
				},
				view = {
					docs = {
						auto_open = false,
					},
				},
				mapping = {
					['<A-m>'] = function(_) -- FIXME: make cmp load on lspattach, and move these mappings so they set up cmp
						if cmp.visible() then
							cmp.abort()
						else
							cmp.complete()
						end
					end,
					['<A-.>'] = function(_)
						if cmp.visible() then
							if cmp.visible_docs() then
								cmp.close_docs()
							else
								cmp.open_docs()
							end
						else
							vim.lsp.buf.signature_help()
						end
					end,
					['<A-;>'] = cmp.mapping.confirm({
						select = true,
						behavior = cmp.ConfirmBehavior.Insert,
					}),
					['<A-,>'] = cmp.mapping.complete({
						config = {
							sources = {
								{
									name = 'buffer-lines',
									priority = 50,
									option = {
										leading_whitespace = false,
									},
								},
							},
						},
					}),
					['<A-n>'] = cmp.mapping.complete({
						config = {
							sources = {
								{ name = 'buffer' },
							},
						},
					}),
					['<C-p>'] = function()
						if cmp.visible() then
							cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
						else
							cmp.complete()
						end
					end,
					['<C-n>'] = function()
						if cmp.visible() then
							cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
						else
							cmp.complete()
						end
					end,
				},
			}
		end,
	},
}
