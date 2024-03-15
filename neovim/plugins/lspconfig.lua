local rust_analyzer_configuration = {
	settings = {
		['rust-analyzer'] = {
			assist = {
				expressionFillDefault = 'default',
			},
			cargo = {
				allFeatures = true,
			},
			check = {
				command = 'clippy',
			},
			completion = {
				fullFunctionSignatures = {
					enable = true,
				},
			},
			procMacro = {
				enable = true,
			},
			inlayHints = {
				bindingModeHints = { enable = true },
				closingBraceHints = { minLines = 11 },
				closureCaptureHints = { enable = true },
				closureReturnTypeHints = { enable = 'with_block' },
				closureStyle = 'rust_analyzer',
				discriminantHints = { enable = 'fieldless' },
				parameterHints = { enable = true },
				rangeExclusiveHints = { enable = true },
				renderColons = false,
				typeHints = {
					enable = true,
					hideClosureInitialization = false,
					hideNamedConstructor = false,
				},
				maxLength = nil,
				expressionAdjustmentHints = {
					enable = 'reborrow',
					hideOutsideUnsafe = false,
					mode = 'prefer_prefix',
				},
				lifetimeElisionHints = {
					enable = 'skip_trivial',
					useParameterNames = false,
				},
			},
			lens = {
				run = { enable = false },
			},
			semanticHighlighting = {
				operator = {
					specialization = { enable = true },
				},
				punctuation = {
					enable = true,
					separate = {
						macro = {
							bang = true,
						},
					},
					specialization = { enable = true },
				},
			},
			typing = {
				autoClosingAngleBrackets = { enable = true },
			},
			workspace = {
				symbol = {
					search = {
						kind = 'all_symbols',
						limit = 128,
					},
				},
			},
			signatureInfo = {
				documentation = { enable = false },
			},
		},
	},
}

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
		config = function()
			require('lspconfig').rust_analyzer.setup(rust_analyzer_configuration)
			require('lspconfig').lua_ls.setup({})
			require('lspconfig').omnisharp.setup({})
			require('lspconfig').cssls.setup({})
			require('lspconfig').html.setup({})
			require('lspconfig').jsonls.setup({})
			require('lspconfig').marksman.setup({})
			require('lspconfig').hydra_lsp.setup({})
			require('lspconfig').taplo.setup({})

			vim.api.nvim_create_autocmd('LspAttach', {
					callback = function(ev)
						-- Enable completion triggered by <c-x><c-o>
						vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

						vim.keymap.set('n', ',lg', function()
							vim.diagnostic.open_float()
							vim.diagnostic.open_float()
						end)
						vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
						vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
						-- See `:help vim.lsp.*` for documentation on any of the below functions
						local opts = { buffer = ev.buf }
						vim.keymap.set('n', ',la', vim.lsp.buf.declaration, opts)
						vim.keymap.set('n', ',le', function()
							vim.lsp.buf.hover()
							vim.lsp.buf.hover()
						end, opts)
						vim.keymap.set('n', ',ls',
							function()
								vim.lsp.buf.signature_help()
								vim.lsp.buf.signature_help()
							end
						, opts)
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
