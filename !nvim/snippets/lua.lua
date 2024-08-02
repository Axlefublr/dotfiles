---@diagnostic disable: undefined-global
return {
	s({ filetype = 'lua', trig = 'si' }, { t('-- stylua: ignore') }),
	s({ filetype = 'lua', trig = 'eh' }, fmta('env.high({ <> })', { i(1) })),
	s({ filetype = 'lua', trig = 'ec' }, { t('env.color.') }),
	s({ filetype = 'lua', trig = 'keys' }, fmta('keys = {\n\t<>\n},', { i(1) })),
	s({ filetype = 'lua', trig = 'key' }, fmta("{ mode = { '<>',<> }, '<>' },", { i(1), i(2), i(3) })),
	s({ filetype = 'lua', trig = 'config' }, fmta('config = function(_, opts)\n\t<>\nend,', { i(1) })),
	s({ filetype = 'lua', trig = 'tde' }, t("vim.tbl_deep_extend('force', ")),
	s({ filetype = 'lua', trig = 'req' }, fmta("require('<>')", { i(1) })),
	s(
		{ filetype = 'lua', trig = 'for' },
		fmta('for <>, <> in <> do\n\t<>\nend', { i(1, 'key'), i(2, 'value'), i(3), i(4) })
	),
	s({ filetype = 'lua', trig = 'do' }, fmta('do\n\t<>\nend', { i(1) })),
	s({ filetype = 'lua', trig = 'r' }, fmta('print(<>)', { i(1) })),
	s({ filetype = 'lua', trig = 'pis' }, fmta('vim.print(<>)', { i(1) })),
	s(
		{ filetype = 'lua', trig = 'event' },
		fmta('event = <>,', {
			c(1, {
				i(1),
				fmta('{ <> }', { i(1) }),
			}),
		})
	),
	s({ filetype = 'lua', trig = 'va' }, { t('vim.api.') }),
	s({ filetype = 'lua', trig = 'van' }, { t('vim.api.nvim_') }),
	s({ filetype = 'lua', trig = 'ntf' }, fmta("vim.notify('<>')", { i(1) })),
	s(
		{ filetype = 'lua', trig = 'opts' },
		fmt('opts = {},', {
			c(1, {
				fmta('{<>}', { i(1) }),
				fmt('function(_, opts)\n\t{}\nend', { i(1) }),
			}),
		})
	),
	s({ filetype = 'lua', trig = 'if' }, fmta('if <> then <> end', { i(1), i(2) })),
	s({ filetype = 'lua', trig = 'eif' }, fmta('elseif <> then <>', { i(1), i(2) })),
	s({ filetype = 'lua', trig = 'else' }, {
		t({ 'else', '\t' }),
	}),
	s({ filetype = 'lua', trig = 'th' }, fmta('then\n\t<>\nend', { i(1) })),
	s({ filetype = 'lua', trig = 'loc' }, { t('local ') }),
	s({ filetype = 'lua', trig = 'vf' }, { t('vim.fn.') }),
	s({ filetype = 'lua', trig = 'vc' }, fmta("vim.cmd('<>')", { i(1) })),
	s(
		{ filetype = 'lua', trig = 'vus' },
		fmta('vim.ui.select(<>, <>, function(<>) <> end)', {
			i(1),
			i(2, '{}'),
			i(3, 'item, index'),
			i(4),
		})
	),
	s({ filetype = 'lua', trig = 'spec' }, {
		t({ '{', "\t'" }),
		i(1),
		t({ "',", '\topts = {' }),
		i(2),
		t({ '},', '},' }),
	}),
	s({ filetype = 'lua', trig = 'esc' }, {
		t('<Esc>'),
	}),
	s(
		{ filetype = 'lua', trig = 'map' },
		fmta("['<>'] = <>,", {
			i(1),
			c(2, {
				fmta("'<>'", { i(1) }),
				fmta('function()\n\t<>\nend', { i(1) }),
			}),
		})
	),
	s({ filetype = 'lua', trig = 'kmap' }, {
		t("vim.keymap.set('"),
		i(1, 'n'),
		t("', '"),
		i(2),
		t("', "),
		i(0),
		t(')'),
	}),
	s({ filetype = 'lua', trig = 'funl' }, {
		t('function'),
		i(1),
		t('('),
		i(2),
		t(') '),
		i(0),
		t(' end'),
	}),
	s({ filetype = 'lua', trig = 'fun' }, {
		t('function'),
		i(1),
		t('('),
		i(2),
		t(')'),
		t({ '', '\t' }),
		i(0),
		t({ '', 'end' }),
	}),
	s({ filetype = 'lua', trig = '#!' }, {
		t({ '#!/usr/bin/lua', '' }),
	}),
	s({ filetype = 'lua', trig = 're' }, {
		t({ 'return ' }),
	}),
	s({ filetype = 'lua', trig = 'ldr' }, { t('<Leader>') }),
	s({ filetype = 'lua', trig = 'q' }, {
		t("'"),
		i(1),
		t("',"),
	}),
	s({ filetype = 'lua', trig = 'jj' }, fmta('{ <> },', { i(1) })),
	s({ filetype = 'lua', trig = 'j' }, {
		t({ '{', '\t' }),
		i(1),
		t({ '', '},' }),
	}),
	s({ filetype = 'lua', trig = 'cmd' }, {
		t('<Cmd>'),
		i(1),
		t('<CR>'),
		i(0),
	}),

	-- Snippet making snippets
	s(
		{ filetype = 'lua', trig = 's' },
		fmta("s(\n\t{ filetype = '<>', trig = '<>' },\n\t\t<>\n\t),", {
			f(function() return vim.fn.expand('%:t:r') end),
			i(1),
			i(2),
		})
	),
	s({ filetype = 'lua', trig = 'fmt' }, fmta("fmt('<>', { <> })", { i(1), i(2) })),
	s({ filetype = 'lua', trig = 'fmta' }, fmta("fmta('<>', { <> })", { i(1), i(2) })),
	s({ filetype = 'lua', trig = 'i' }, fmta('i(<>),', { i(1, '1') })),
	s(
		{ filetype = 'lua', trig = 't' },
		fmta('t(<>),', {
			c(1, {
				fmta("'<>'", { i(1) }),
				fmta("{ '<>',<> }", { i(1), i(2) }),
			}),
		})
	),
	s(
		{ filetype = 'lua', trig = 'c' },
		fmta('c(<>, {\n\t<>\n})', {
			i(1, '1'),
			i(2),
		})
	),
	s(
		{ filetype = 'lua', trig = 'f' },
		fmta('f(function()\n\t<>\nend),', {
			i(1),
		})
	),
}
