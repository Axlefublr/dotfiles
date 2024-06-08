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
		s('ff2930', {
			t('ff2930'),
		}),
		s('ff9f1a', {
			t('ff9f1a'),
		}),
		s('ffd75f', {
			t('ffd75f'),
		}),
		s('87ff5f', {
			t('87ff5f'),
		}),
		s('3dff47', {
			t('3dff47'),
		}),
		s('00d7ff', {
			t('00d7ff'),
		}),
		s('af87ff', {
			t('af87ff'),
		}),
		s('ffafd7', {
			t('ffafd7'),
		}),
		s('ff8787', {
			t('ff8787'),
		}),
		s('878787', {
			t('878787'),
		}),
		s('ea6962', {
			t('ea6962'),
		}),
		s('e49641', {
			t('e49641'),
		}),
		s('d3ad5c', {
			t('d3ad5c'),
		}),
		s('a9b665', {
			t('a9b665'),
		}),
		s('78bf84', {
			t('78bf84'),
		}),
		s('7daea3', {
			t('7daea3'),
		}),
		s('b58cc6', {
			t('b58cc6'),
		}),
		s('e491b2', {
			t('e491b2'),
		}),
		s('d4be98', {
			t('d4be98'),
		}),
		s('928374', {
			t('928374'),
		}),
		s('403f3f', {
			t('403f3f'),
		}),
		s('313030', {
			t('313030'),
		}),
		s('212121', {
			t('212121'),
		}),
		s('1f1e1e', {
			t('1f1e1e'),
		}),
		s('1a1919', {
			t('1a1919'),
		}),
		s('292828', {
			t('292828'),
		}),
		s('0f0f0f', {
			t('0f0f0f'),
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
		s('funl', {
			t('function'),
			i(1),
			t('('),
			i(2),
			t(') '),
			i(0),
			t(' end'),
		}),
		s('func', {
			t('function'),
			i(1),
			t('('),
			i(2),
			t(')'),
			t({ '', '\t' }),
			i(0),
			t({ '', 'end' }),
		}),
	}
	ls.add_snippets('lua', lua_snippets)

	local fish_snippets = {
		s('#!', {
			t({ '#!/usr/bin/env fish', '' }), -- {} in a t is a multiline text node, every separate string is its own line
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
		s('alias', {
			t('alias --save '),
			i(1),
			t(" '"),
			i(0),
			t("' >/dev/null"),
		}),
		s('read', {
			t('read -p rdp'),
		}),
		s('xcp', {
			t('xclip -r -selection clipboard'),
		}),
		s('xpc', {
			t('xclip -selection clipboard -o'),
		}),
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
		s('kitty', { t('kitty: ') }),
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
		opts = function() snippets() end,
	},
}
