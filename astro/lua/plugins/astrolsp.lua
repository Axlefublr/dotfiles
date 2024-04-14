---@type AstroLSPOpts
local opts_table = {
	features = {
		autoformat = false,
		codelens = true,
		inlay_hints = false,
		semantic_tokens = true,
	},
	formatting = {
		format_on_save = {
			enabled = false,
			allow_filetypes = {},
			ignore_filetypes = {},
		},
		disabled = {
			'lua_ls',
		},
		timeout_ms = 1000, -- default format timeout
	},
	---@diagnostic disable: missing-fields
	config = {
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
						autoClosingAngleBrackets = { enable = true }
					},
					semanticHighlighting = {
						operator = {
							specialization = { enable = true },
						},
						punctuation = {
							separate = {
								macro = {
									bang = true
								}
							},
							enable = true,
						},
					},
					workspace = {
						symbol = {
							search = {
								kind = 'all_symbols'
							}
						}
					},
					signatureInfo = {
						documentation = {
							enable = false
						}
					}
				},
			},
		},
	},
}

---@type LazySpec
return {
	'AstroNvim/astrolsp',
	---@param opts AstroLSPOpts
	opts = function(_, opts)
		opts.mappings = nil
		return require('astrocore').extend_tbl(opts, opts_table)
	end,
}
