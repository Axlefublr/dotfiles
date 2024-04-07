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
					require('null-ls').builtins.formatting.prettierd.with({
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
					require('null-ls').builtins.diagnostics.sqlfluff.with({
						extra_args = { '--dialect', 'postgres' },
					}),
					require('null-ls').builtins.formatting.fish_indent,
					require('null-ls').builtins.diagnostics.fish,
					require('null-ls').builtins.diagnostics.actionlint,
					require('null-ls').builtins.diagnostics.selene,
					require('null-ls').builtins.diagnostics.tidy,
					require('null-ls').builtins.diagnostics.todo_comments,
					require('null-ls').builtins.diagnostics.trail_space,
					require('null-ls').builtins.formatting.csharpier
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
		},
	},
}
