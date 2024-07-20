local snippets = function()
	local ls = require('luasnip')
	local s = ls.snippet
	local f = ls.function_node
	local t = ls.text_node
	local i = ls.insert_node
	local c = ls.choice_node
	local extras = require('luasnip.extras')
	local rep = extras.rep
	local fmt = require('luasnip.extras.fmt').fmt
	local fmta = require('luasnip.extras.fmt').fmta

	local all_snippets = {
		s('asi', {
			f(function()
				local result = env.shell('uclanr'):wait()
				if result.code ~= 0 then return '' end
				return result.stdout:trim()
			end),
		}),
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
		s('shred', {
			t('ff2930'),
		}),
		s('shorange', {
			t('ff9f1a'),
		}),
		s('shyellow', {
			t('ffd75f'),
		}),
		s('shsalad', {
			t('87ff5f'),
		}),
		s('shgreen', {
			t('3dff47'),
		}),
		s('shcyan', {
			t('00d7ff'),
		}),
		s('shpurple', {
			t('af87ff'),
		}),
		s('shpink', {
			t('ffafd7'),
		}),
		s('shcoral', {
			t('ff8787'),
		}),
		s('shgrey', {
			t('878787'),
		}),
		s('grred', {
			t('ea6962'),
		}),
		s('grorange', {
			t('e49641'),
		}),
		s('gryellow', {
			t('d3ad5c'),
		}),
		s('grgreen', {
			t('a9b665'),
		}),
		s('grmint', {
			t('78bf84'),
		}),
		s('grcyan', {
			t('7daea3'),
		}),
		s('grpurple', {
			t('b58cc6'),
		}),
		s('grblush', {
			t('e491b2'),
		}),
		s('grwhite', {
			t('d4be98'),
		}),
		s('grgrey', {
			t('928374'),
		}),
		s('grlight25', {
			t('403f3f'),
		}),
		s('grlight19', {
			t('313030'),
		}),
		s('grdark13', {
			t('212121'),
		}),
		s('grdark12', {
			t('1f1e1e'),
		}),
		s('grdark10', {
			t('1a1919'),
		}),
		s('grbg', {
			t('292828'),
		}),
		s('shblack', {
			t('0f0f0f'),
		}),
	}
	ls.add_snippets('all', all_snippets)

	local lua_snippets = {
		s(
			'opts',
			fmt('opts = {},', {
				c(1, {
					fmta('{<>}', { i(1) }),
					fmt('function(_, opts)\n\t{}\nend', { i(1) }),
				}),
			})
		),
		s('if', fmta('if <> then\n\t<>\nend', { i(1), i(2) })),
		s('eif', fmta('elseif <> then\n\t<>', { i(1), i(2) })),
		s('ife', fmta('if <> == <> then\n\t<>\nend', { i(1), i(2), i(3) })),
		s('eife', fmta('elseif <> == <> then\n\t<>', { i(1), i(2), i(3) })),
		s('th', fmta('then\n\t<>\nend', { i(1) })),
		s('loc', { t('local ') }),
		s('vf', { t('vim.fn.') }),
		s('else', {
			t({ 'else', '\t' }),
		}),
		s('spec', {
			t({ '{', "\t'" }),
			i(1),
			t({ "',", '\topts = {' }),
			i(2),
			t({ '},', '},' }),
		}),
		s('esc', {
			t('<Esc>'),
		}),
		s(
			'map',
			fmta("['<>'] = <>,", {
				i(1),
				c(2, {
					fmta("'<>'", { i(1) }),
					fmta('function()\n\t<>\nend', { i(1) }),
				}),
			})
		),
		s('kmap', {
			t("vim.keymap.set('"),
			i(1, 'n'),
			t("', '"),
			i(2),
			t("', "),
			i(0),
			t(')'),
		}),
		s('fnl', {
			t('function'),
			i(1),
			t('('),
			i(2),
			t(') '),
			i(0),
			t(' end'),
		}),
		s('fn', {
			t('function'),
			i(1),
			t('('),
			i(2),
			t(')'),
			t({ '', '\t' }),
			i(0),
			t({ '', 'end' }),
		}),
		s('#!', {
			t({ '#!/usr/bin/lua', '' }),
		}),
		s('rn', {
			t({ 'return ' }),
		}),
		s('ldr', { t('<Leader>') }),
		s('qq', {
			t("'"),
			i(1),
			t("',"),
		}),
		s('jj', {
			t({ '{', '\t' }),
			i(1),
			t({ '', '},' }),
		}),
		s('cmd', {
			t('<Cmd>'),
			i(1),
			t('<CR>'),
			i(0),
		}),

		-- Snippet making snippets
		s(
			's',
			fmta("s('<>', <>),", {
				i(1),
				c(2, { fmta('{ <> }', i(1)), i(1) }),
			})
		),
		s('fmt', fmta("fmt('<>', { <> })", { i(1), i(2) })),
		s('fmta', fmta("fmta('<>', { <> })", { i(1), i(2) })),
		s('i', fmta('i(<><>),', { i(1, '1'), i(2) })),
		s(
			't',
			fmta('t(<>),', {
				c(1, {
					fmta("{ '<>',<> }", { i(1), i(2) }),
					fmta("'<>'", { i(1) }),
				}),
			})
		),
		s(
			'c',
			fmta('c(<>, {\n\t<>\n})', {
				i(1, '1'),
				i(2),
			})
		),
		s(
			'f',
			fmta('f(<>, function()\n\t<>\nend),', {
				i(1, '1'),
				i(2),
			})
		),
	}
	ls.add_snippets('lua', lua_snippets)

	local fish_snippets = {
		s('if', {
			t('if '),
			i(1),
			t({ '', '\t' }),
			i(2),
			t({ '', 'end' }),
		}),
		s('#!', {
			t({ '#!/usr/bin/env fish', '' }), -- {} in a t is a multiline text node, every separate string is its own line
		}),
		s('fn', {
			t('function '),
			i(1),
			t({ '', '    ' }),
			i(0),
			t({ '', 'end' }),
		}),
		s('fns', {
			t('function '),
			i(1),
			t({ '', '    ' }),
			i(0),
			t({ '', 'end', 'funcsave ' }),
			rep(1),
			t(' >/dev/null'),
		}),
		s('ift', {
			t('if test '),
			i(1),
			t({ '', '    ' }),
			i(0),
			t({ '', 'end' }),
		}),
		s('elseift', {
			t('else if test '),
			i(1),
			t({ '', '    ' }),
		}),
		s('fcs', {
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
		s('ali', {
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
		s('as', { t('astro: ') }),
		s('awm', { t('awesome: ') }),
		s('cps', { t('compose: ') }),
		s('xr', { t('xremap: ') }),
		s('sty', { t('stylus(youtube): ') }),
		s('std', { t('stylus(discord): ') }),
		s('kit', { t('kitty: ') }),
		s('pkg', { t('pkg: ') }),
	}
	ls.add_snippets('gitcommit', git_commit_snippets)

	local css_snippets = {
		s('imp', { t('!important') }),
	}
	ls.add_snippets('css', css_snippets)

	local rust_snippets = {
		s('rbde', {
			t('Result<'),
			i(1, '()'),
			t(', Box<dyn Error>>'),
		}),
	}
	ls.add_snippets('rust', rust_snippets)

	local markdown_snippets = {
		s('inl', {
			t('['),
			i(1),
			t(']('),
			i(2),
			t(')'),
		}),
		s('kbd', { t('<kbd>'), i(1), t('</kbd>'), i(0) }),
	}
	ls.add_snippets('markdown', markdown_snippets)

	local yaml_snippets = {
		s('apo', { t('Apostrophe') }),
		s(';', { t('Semicolon') }),
		s('c', { t('CapsLock') }),
		s('lb', { t('LeftBrace') }),
		s('rb', { t('RightBrace') }),
		s('\\', { t('Backslash') }),
		s('launch', {
			t('{ launch: ['),
			i(0),
			t('] }'),
		}),
		s('sm', {
			t('{ set_mode: '),
			i(1, 'default'),
			t(' }'),
		}),
	}
	ls.add_snippets('yaml', yaml_snippets)

	local python_snippets = {
		s('#!', { t('#!/usr/bin/python') }),
	}
	ls.add_snippets('python', python_snippets)

	local xcompose_snippets = {
		s('multi_key', {
			t('<Multi_key> <'),
			i(1),
			t('> <'),
			i(2),
			t('> <'),
			i(3),
			t('>: "'),
			i(4),
			t('"'),
		}),
	}
	ls.add_snippets('xcompose', xcompose_snippets)

	local html_snippets = {
		s('cc', {
			t('{{c1::'),
			i(1),
			t('}}'),
		}),
		s('cda', {
			t({ '<div class="codeblock above">', '\t' }),
			i(0),
			t({ '', '</div>' }),
		}),
		s('cdb', {
			t({ '<div class="codeblock below">', '\t' }),
			i(0),
			t({ '', '</div>' }),
		}),
	}
	ls.add_snippets('html', html_snippets)
end

return {
	{
		'L3MON4D3/LuaSnip',
		opts = function() snippets() end,
	},
}
