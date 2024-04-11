---@type LazySpec
return {
	'AstroNvim/astrolsp',
	---@param opts AstroLSPOpts
	opts = function(_, opts)
		opts.mappings = nil
		opts.autocmds.lsp_document_highlight = nil
		return require('astrocore').extend_tbl(opts, {
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
		})
	end,
}
