local snippets = function()
	local ls = require('luasnip')
	local s = ls.snippet
	local f = ls.function_node
	local t = ls.text_node
	local i = ls.insert_node
	local c = ls.choice_node
	local extras = require('luasnip.extras')
	local rep = extras.rep

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
		s('sh_red', {
			t('ff2930'),
		}),
		s('sh_orange', {
			t('ff9f1a'),
		}),
		s('sh_yellow', {
			t('ffd75f'),
		}),
		s('sh_salad', {
			t('87ff5f'),
		}),
		s('sh_green', {
			t('3dff47'),
		}),
		s('sh_cyan', {
			t('00d7ff'),
		}),
		s('sh_purple', {
			t('af87ff'),
		}),
		s('sh_pink', {
			t('ffafd7'),
		}),
		s('sh_coral', {
			t('ff8787'),
		}),
		s('sh_grey', {
			t('878787'),
		}),
		s('gr_red', {
			t('ea6962'),
		}),
		s('gr_orange', {
			t('e49641'),
		}),
		s('gr_yellow', {
			t('d3ad5c'),
		}),
		s('gr_green', {
			t('a9b665'),
		}),
		s('gr_mint', {
			t('78bf84'),
		}),
		s('gr_cyan', {
			t('7daea3'),
		}),
		s('gr_purple', {
			t('b58cc6'),
		}),
		s('gr_blush', {
			t('e491b2'),
		}),
		s('gr_white', {
			t('d4be98'),
		}),
		s('gr_grey', {
			t('928374'),
		}),
		s('gr_light25', {
			t('403f3f'),
		}),
		s('gr_light19', {
			t('313030'),
		}),
		s('gr_dark13', {
			t('212121'),
		}),
		s('gr_dark12', {
			t('1f1e1e'),
		}),
		s('gr_dark10', {
			t('1a1919'),
		}),
		s('gr_background', {
			t('292828'),
		}),
		s('sh_black', {
			t('0f0f0f'),
		}),
	}
	ls.add_snippets('all', all_snippets)

	local lua_snippets = {
		s('opts', {
			t({ 'opts = {', '\t' }),
			i(1),
			t({ '', '},' })
		}),
		s('event', {
			t('event = '),
			c(1, {
				t('{ '),
				t('')
			}),
			t("'"),
			i(2),
			t("'"),
			f(function(node)
				if node[1][1] == '' then return '' else return ' }' end
			end, 1),
			t(',')
		}),
		s('if', {
			t('if '),
			i(1),
			t({ ' then', '' }),
			i(2),
			t({ '', 'end' }),
		}),
		s('eif', {
			t('elseif '),
			i(1),
			t({ ' then', '' }),
		}),
		s('eife', {
			t('elseif '),
			i(1),
			t(' == '),
			i(2),
			t({ ' then', '' })
		}),
		s('else', {
			t({ 'else', '' }),
		}),
		s('spec', {
			t({ '{', "\t'" }),
			i(1),
			t({ "',", '\topts = {' }),
			i(2),
			t({ '},', '},' }),
		}),
		s('Esc', {
			t('<Esc>'),
		}),
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
		s('#!', {
			t({ '#!/usr/bin/lua', '' }),
		}),
		s('rn', {
			t({ 'return' }),
		}),
		s('ldr', { t('<Leader>') }),
		s('snp', {
			t("s('"),
			i(1),
			t({ "', {", '\t' }),
			i(2, 't'),
			t("('"),
			i(3),
			t("'),"),
			i(4),
			t({ '', '}),' }),
		}),
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
		s('func', {
			t('function '),
			i(1),
			t({ '', '    ' }),
			i(0),
			t({ '', 'end' }),
		}),
		s('func+s', {
			t('function '),
			i(1),
			t({ '', '    ' }),
			i(0),
			t({ '', 'end', 'funcsave ' }),
			rep(1),
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
		s('Apostrophe', { t('Apostrophe') }),
		s('Semicolon', { t('Semicolon') }),
		s('CapsLock', { t('CapsLock') }),
		s('LeftBrace', { t('LeftBrace') }),
		s('RightBrace', { t('RightBrace') }),
		s('Backslash', { t('Backslash') }),
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
