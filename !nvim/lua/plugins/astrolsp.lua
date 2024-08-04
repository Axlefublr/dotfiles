---@type LazyPluginSpec
return {
	'AstroNvim/astrolsp',
	lazy = true,
	pin = true,
	---@param prevopts AstroLSPOpts
	opts = function(_, prevopts)
		---@type AstroLSPOpts
		local opts = {
			features = {
				-- autoformat = false,
				codelens = false,
				inlay_hints = true,
				semantic_tokens = true,
			},
			capabilities = vim.lsp.protocol.make_client_capabilities(),
			handlers = {
				function(server, server_opts) require('lspconfig')[server].setup(server_opts) end,
				rust_analyzer = false,
			},
			formatting = {
				disabled = true,
			},
			on_attach = nil,
			lsp_handlers = {
				['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
					border = env.borders,
				}),
				['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
					border = env.borders,
				}),
			},
			servers = env.lsps,
			---@diagnostic disable: missing-fields
			config = {
				html = {
					init_options = { provideFormatter = false },
				},
				cssls = {
					init_options = { provideFormatter = false },
				},
				pyright = {
					before_init = function(_, client) client.settings.python.pythonPath = vim.fn.exepath('python') end,
				},
				lua_ls = {
					settings = {
						Lua = {
							codeLens = {
								enable = true,
							},
							completion = {
								callSnippet = 'Replace',
								enable = true,
								keywordSnippet = 'Disable',
								postfix = '@',
								showParams = true,
								showWord = 'Disable',
								workspaceWord = false,
							},
							diagnostics = {
								disable = { 'lowercase-global', 'redefined-local' },
								workspaceDelay = 0,
							},
							format = {
								enable = false,
							},
							hint = {
								arrayIndex = 'Disable',
								await = true,
								enable = true,
								paramName = 'Disable',
								paramType = true,
								semicolon = 'Disable',
								setType = true,
							},
							hover = {
								enable = true,
								enumsLimit = 9999,
								expandAlias = true,
								previewFields = 9999,
								viewNumber = true,
								viewString = true,
							},
							semantic = {
								enable = true,
								keyword = false,
								variable = true,
							},
							type = {
								weakNilCheck = false,
							},
							workspace = {
								checkThirdParty = false,
							},
						},
					},
				},
				rust_analyzer = {
					on_attach = function(_, bufnr)
						pcall(vim.keymap.del, 'n', 'K', { buffer = bufnr })
						env.map(
							'n',
							'gl',
							function() vim.cmd('RustLsp renderDiagnostic current') end,
							{ buffer = bufnr }
						)
					end,
					settings = {
						['rust-analyzer'] = {
							checkOnSave = {
								command = 'clippy',
							},
							cargo = {
								extraEnv = { CARGO_PROFILE_RUST_ANALYZER_INHERITS = 'dev' },
								extraArgs = { '--profile', 'rust-analyzer' },
								features = 'all',
							},
							rustfmt = {
								extraArgs = { '+nightly' },
							},
							assist = {
								expressionFillDefault = 'default',
								importEnforceGranularity = true,
								importPrefix = 'crate',
							},
							inlayHints = {
								-- typeHints = { enable = true }
								bindingModeHints = { enable = true },
								closingBraceHints = {
									minLines = 11,
								},
								closureCaptureHints = { enable = true },
								closureReturnTypeHints = {
									enable = 'with_block',
								},
								closureStyle = 'rust_analyzer',
								discriminantHints = {
									enable = 'fieldless',
								},
								parameterHints = {
									enable = true,
								},
								rangeExclusiveHints = {
									enable = true,
								},
								renderColons = false,
								-- maxLength = 0,
								expressionAdjustmentHints = {
									mode = 'prefer_postfix',
									enable = 'reborrow',
								},
								lifetimeElisionHints = {
									enable = 'skip_trivial',
									useParameterNames = true,
								},
							},
							lens = {
								run = { enable = false },
							},
							completion = {
								fullFunctionSignatures = { enable = true },
							},
							procMacro = { enable = true },
							typing = {
								autoClosingAngleBrackets = { enable = true },
							},
							semanticHighlighting = {
								operator = {
									specialization = { enable = true },
								},
								punctuation = {
									separate = {
										macro = {
											bang = true,
										},
									},
									enable = true,
								},
							},
							workspace = {
								symbol = {
									search = {
										kind = 'onlyTypes',
									},
								},
							},
							signatureInfo = {
								documentation = {
									enable = false,
								},
							},
						},
					},
				},
			},
		}
		return vim.tbl_deep_extend('force', opts, prevopts)
	end,
}
