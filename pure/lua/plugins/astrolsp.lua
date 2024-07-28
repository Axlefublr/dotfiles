return {
	'AstroNvim/astrolsp',
	opts = function(_, opts)
		return vim.tbl_deep_extend('force', opts, {
			features = {
				-- autoformat = false,
				codelens = false,
				inlay_hints = true,
				semantic_tokens = true,
			},
			capabilities = vim.lsp.protocol.make_client_capabilities(),
			handlers = { function(server, server_opts) require('lspconfig')[server].setup(server_opts) end },
			formatting = {
				disabled = true,
			},
			on_attach = nil,
			-- lsp_handlers = { -- MOVE: your LspAttach autocommand into here
			-- 	['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded', silent = true }),
			-- 	['textDocument/signatureHelp'] = vim.lsp.with(
			-- 		vim.lsp.handlers.signature_help,
			-- 		{ border = 'rounded', silent = true }
			-- 	),
			-- },
			---@diagnostic disable: missing-fields
			config = {
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
					settings = {
						['rust-analyzer'] = {
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
										kind = 'all_symbols',
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
		})
	end,
}
