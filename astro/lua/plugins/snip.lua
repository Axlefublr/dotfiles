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
			t(' >/dev/null'),
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
		s('/dev/shm', {
			t('/dev/shm/'),
		}),
		s('/dev/null', {
			t('/dev/null'),
		}),
		s('alias', {
			t('alias --save '),
			i(1),
			t(" '"),
			i(0),
			t("' >/dev/null"),
		}),
		s('read', {
			t('read -p rdp '),
		}),
		s('xcp', {
			t('xclip -r -selection clipboard'),
		}),
		s('xpc', {
			t('xclip -selection clipboard -o')
		})
	}
	ls.add_snippets('fish', fish_snippets)

	local git_commit_snippets = {
		s('fish', { t('fish: ') }),
		s('astro', { t('astro: ') }),
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
			t(', Box<dyn Error>>'),
		}),
	}
	ls.add_snippets('rust', rust_snippets)

	local markdown_snippets = {
		s('inline link', {
			t('['),
			i(1),
			t(']('),
			i(2),
			t(')'),
		}),
	}
	ls.add_snippets('markdown', markdown_snippets)
end

return {
	{
		'L3MON4D3/LuaSnip',
		opts = function()
			snippets()
		end
	},
}
