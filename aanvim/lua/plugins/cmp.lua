---@type LazyPluginSpec[]
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
			{ 'hrsh7th/cmp-path' },
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'onsails/lspkind.nvim' },
		},
		opts = function()
			local cmp = require('cmp')
			return {
				completion = {
					autocomplete = false,
				},
				sources = {
					{ name = 'nvim_lsp', priority = 1000 },
					{ name = 'path', priority = 250 },
					{ name = 'lazydev', group_index = 0 },
				},
				preselect = cmp.PreselectMode.None,
				formatting = {
					fields = { 'kind', 'abbr', 'menu' },
					format = require('lspkind').cmp_format(env.plugopts('lspkind.nvim')),
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
						scrolloff = 999,
						scrollbar = false,
						border = false,
					},
					documentation = {
						border = env.borders,
					},
				},
				-- experimental = {
				-- 	ghost_text = true
				-- },
				view = {
					entries = {
						follow_cursor = true,
					},
					docs = {
						auto_open = false,
					},
				},
			}
		end,
		config = function(_, opts)
			env.set_high('CmpItemKindSnippet', { link = 'Yellow' })
			env.set_high('CmpItemAbbrMatch', { fg = env.color.shell_yellow, bold = true })
			env.set_high('CmpItemAbbrMatchFuzzy', { fg = env.color.shell_yellow, bold = true })
			env.set_high('CmpItemKindClass', { link = 'Orange' })
			require('cmp').setup(opts)
		end,
	},
}
