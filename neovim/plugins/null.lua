return {
	{
		'nvimtools/none-ls.nvim',
		main = 'null-ls',
		dependencies = 'plenary.nvim',
		config = function() -- works with config function, doesn't with `opts`
			require('null-ls').setup({
				sources = {
					require('null-ls').builtins.formatting.stylua.with({
						extra_args = {
							'--call-parentheses',
							'Always',
							'--collapse-simple-statement',
							'Always',
							'--column-width',
							'100',
							'--indent-type',
							'Tabs',
							'--line-endings',
							'Unix',
							'--quote-style',
							'AutoPreferSingle',
						},
					}),
					require('null-ls').builtins.formatting.prettier.with({
						extra_args = {
							-- '--no-bracket-spacing',
							'--print-width',
							'100',
							'--single-quote',
							'--use-tabs',
						},
						filetypes = {
							'javascript',
							'javascriptreact',
							'typescript',
							'typescriptreact',
							'vue',
							'css',
							'scss',
							'less',
							'html',
							'json',
							'jsonc',
							'yaml',
							'graphql',
							'handlebars',
						},
					}),
					require('null-ls').builtins.diagnostics.fish,
					-- require('null-ls').builtins.diagnostics.commitlint,
					-- require('null-ls').builtins.diagnostics.gitlint,
					require('null-ls').builtins.formatting.fish_indent,
					-- require('null-ls').builtins.hover.dictionary,
				},
			})
		end,
	},
	{
		'jay-babu/mason-null-ls.nvim',
		event = { 'BufReadPre', 'BufNewFile' },
		dependencies = { 'mason.nvim', 'none-ls.nvim' },
		opts = {
			automatic_installation = true,
			handlers = {},
			methods = {
				diagnostics = true,
				formatting = true,
				code_actions = true,
				completion = true,
				hover = true,
			},
		},
	},
}
