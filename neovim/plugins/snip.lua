local snippets = function()
	local ls = require('luasnip')
	local s = ls.snippet
	local f = ls.function_node
	local t = ls.text_node
	local i = ls.insert_node
	local single = function(node) return node[1] end

	local all_snippets = {
		s('wd', {
			---@diagnostic disable-next-line: param-type-mismatch
			f(function() return string.lower(os.date('%A')) end),
		}),
		s('Wd', {
			f(function() return os.date('%A') end),
		}),
		s('dt', {
			f(function() return os.date('%y.%m.%d') end),
		}),
		s('tm', {
			f(function() return os.date('%H:%M') end),
		}),
	}
	ls.add_snippets('all', all_snippets)

	local lua_snippets = {
		s('map', {
			t("vim.keymap.set('"),
			i(1, 'n'),
			t("', '"),
			i(2),
			t("', "),
			i(0),
			t(')'),
		}),
		s('function inline', {
			t('function'),
			i(1),
			t('('),
			i(2),
			t(') '),
			i(0),
			t(' end'),
		}),
	}
	ls.add_snippets('lua', lua_snippets)

	local fish_snippets = {
		s('#!', {
			t({ '#!/usr/bin/env fish', '' }), -- {} in a t is a multiline text node
		}),
		s('function', {
			t('function '),
			i(1),
			t({ '', '    ' }),
			i(0),
			t({ '', 'end' }),
		}),
		s('function save', {
			t('function '),
			i(1),
			t({ '', '    ' }),
			i(0),
			t({ '', 'end', 'funcsave ' }),
			f(single, 1),
			t(' > /dev/null'),
		}),
		s('if test', {
			t('if test '),
			i(1),
			t({ '', '    ' }),
			i(0),
			t({ '', 'end' }),
		}),
		s('else if test', {
			t('else if test '),
			i(1),
			t({ '', '    ' }),
		}),
		s('funcsave', {
			t('funcsave '),
			i(0),
			t(' >/dev/null'),
		}),
		s('while', {
			t('while '),
			i(1),
			t({ '', '    ' }),
			i(0),
			t({ '', 'end' }),
		}),
		s(',sr', {
			t('>/dev/null'),
		}),
		s(',er', {
			t('2>/dev/null'),
		}),
		s(',ar', {
			t('&>/dev/null'),
		}),
		s('alias', {
			t('alias --save '),
			i(1),
			t(" '"),
			i(0),
			t("' >/dev/null"),
		}),
	}
	ls.add_snippets('fish', fish_snippets)

	local git_commit_snippets = {
		s('fish', { t('fish: ') }),
		s('nvim', { t('nvim: ') }),
		s('awesome', { t('awesome: ') }),
		s('compose', { t('compose: ') }),
		s('xremap', { t('xremap: ') }),
		s('alacritty', { t('alacritty: ') }),
		s('stylus(youtube)', { t('stylus(youtube): ') }),
		s('stylus(discord)', { t('stylus(discord): ') }),
	}
	ls.add_snippets('gitcommit', git_commit_snippets)

	local css_snippets = {
		s('!important', { t('!important') }),
	}
	ls.add_snippets('css', css_snippets)

	local rust_snippets = {
		s('Result<(), Box<dyn Error>>', {
			t('Result<'),
			i(1, '()'),
			t(', Box<dyn Error>>')
		})
	}
	ls.add_snippets('rust', rust_snippets)
end

return {
	{
		'L3MON4D3/LuaSnip',
		version = 'v2.*',
		lazy = 'InsertEnter',
		build = 'make install_jsregexp',
		config = function()
			snippets()

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
		event = 'InsertEnter',
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
					['<a-i>'] = function (_)
						if cmp.visible_docs() then
							cmp.close_docs()
						else
							cmp.open_docs()
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
				}),
				sources = cmp.config.sources({
					{ name = 'luasnip' },
					{ name = 'nvim_lsp' },
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
